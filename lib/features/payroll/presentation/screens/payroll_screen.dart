import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hrm_mobile/config/theme.dart';
import 'package:hrm_mobile/features/auth/auth_provider.dart';
import '../../payroll_provider.dart';

class PayrollScreen extends ConsumerStatefulWidget {
  const PayrollScreen({super.key});

  @override
  ConsumerState<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends ConsumerState<PayrollScreen> {
  String? _selectedPeriodId;
  bool _hasInvalidated = false;

  @override
  void initState() {
    super.initState();
    // Invalidate providers when screen is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasInvalidated) {
        _invalidateProviders();
        _hasInvalidated = true;
      }
    });
  }

  void _invalidateProviders() {
    // Invalidate cached data to force fresh API calls
    ref.invalidate(payrollPeriodsProvider);
    // Invalidate all payslip providers
    ref.invalidate(payslipProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Chi tiết bảng lương'),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Month selector
          Consumer(
            builder: (context, ref, child) {
              final payrollPeriodsAsync = ref.watch(payrollPeriodsProvider);
              
              return payrollPeriodsAsync.when(
                data: (periods) {
                  // Set first period as default if not selected
                  if (_selectedPeriodId == null && periods.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() => _selectedPeriodId = periods.first.id);
                    });
                  }
                  
                  return DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedPeriodId ?? (periods.isNotEmpty ? periods.first.id : null),
                    items: periods
                        .map((period) => DropdownMenuItem(
                              value: period.id,
                              child: Text(period.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() => _selectedPeriodId = value);
                      // Invalidate payslip when period changes
                      if (value != null) {
                        final user = ref.read(userProvider);
                        final employeeId = user?.employee?.id?.trim();
                        if (employeeId != null && employeeId.isNotEmpty) {
                          ref.invalidate(payslipProvider((employeeId: employeeId, payrollPeriodId: value)));
                        }
                      }
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text('Lỗi: $error'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Detailed payslip content
          Consumer(
            builder: (context, ref, child) {
              final payrollPeriodsAsync = ref.watch(payrollPeriodsProvider);
              
              return payrollPeriodsAsync.when(
                data: (periods) {
                  final selectedPeriod = periods.firstWhereOrNull(
                    (p) => p.id == _selectedPeriodId,
                  ) ?? (periods.isNotEmpty ? periods.first : null);
                  
                  // Get employee ID from auth service via Riverpod
                  final user = ref.watch(userProvider);
                  final employeeId = user?.employee?.id?.trim();
                  
                  if (employeeId == null || employeeId.isEmpty || selectedPeriod == null) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            employeeId == null ? 'Vui lòng đăng nhập lại' : 'Không thể tải bảng lương',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    );
                  }
                  
                  // Fetch payslip data - refresh each time to avoid caching
                  final payslipAsync = ref.watch(payslipProvider(
                    (employeeId: employeeId, payrollPeriodId: selectedPeriod.id),
                  ));
                  
                  return payslipAsync.when(
                    data: (payslip) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // I. Thông tin cơ bản
                          _buildSection(
                            context,
                            'I. THÔNG TIN CƠ BẢN',
                            [
                              _PayslipRow('Nhân viên', '${_safeString(payslip.employeeName)} (${_safeString(payslip.employeeCode)})'),
                              _PayslipRow('Kỳ lương', _safeString(payslip.payrollPeriodName)),
                              _PayslipRow('Người tạo bảng lương', _safeString(payslip.createdBy)),
                              _PayslipRow('Trạng thái duyệt', 'Đã duyệt', isBold: true),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // II. Thu nhập
                          _buildSection(
                            context,
                            'II. THU NHẬP',
                            [
                              _PayslipRow('(1) Lương cơ sở', _formatCurrency(payslip.grossSalary ?? 0)),
                              _PayslipRow('(2) Số ngày công tính lương', _formatInt(payslip.totalWorkdays ?? 0)),
                              _PayslipRow('(3) Số ngày công thực tế', _formatInt(payslip.workdays ?? 0)),
                              _PayslipRow('(4) Lương thanh toán theo công = (1) * (3) / (2)', _formatCurrency(payslip.salaryByWorkdays ?? 0)),
                              _PayslipRow('(5) Phụ cấp chịu thuế + tính bảo hiểm', _formatCurrency(payslip.taxableAndInsurableAllowance ?? 0)),
                              _PayslipRow('(6) Phụ cấp chịu thuế + không tính bảo hiểm', _formatCurrency(payslip.taxableAndNonInsurableAllowance ?? 0)),
                              _PayslipRow('(7) Phụ cấp không chịu thuế + tính bảo hiểm', _formatCurrency(payslip.nonTaxableAndInsurableAllowance ?? 0)),
                              _PayslipRow('(8) Phụ cấp không chịu thuế + không tính bảo hiểm', _formatCurrency(payslip.nonTaxableAndNonInsurableAllowance ?? 0)),
                              _PayslipRow('(9) Thưởng/Phạt chịu thuế', _formatCurrency(payslip.totalBonus ?? 0)),
                              _PayslipRow('(10) Thưởng/Phạt không chịu thuế', _formatCurrency(payslip.totalBonusNonTax ?? 0)),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // III. Bảo hiểm xã hội
                          _buildSection(
                            context,
                            'III. BẢO HIỂM XÃ HỘI',
                            [
                              _PayslipRow('(11) Cơ sở tính bảo hiểm', _formatCurrency(payslip.bhxhSalaryBase ?? 0)),
                              _PayslipRow(
                                '(12) Lương đóng bảo hiểm = (4) + (5) + (7) + (11)',
                                _formatCurrency(
                                  (payslip.salaryByWorkdays ?? 0) +
                                  (payslip.taxableAndInsurableAllowance ?? 0) +
                                  (payslip.nonTaxableAndInsurableAllowance ?? 0) +
                                  (payslip.bhxhSalaryBase ?? 0),
                                ),
                              ),
                              _PayslipRow('(13) BHXH', _formatCurrency(payslip.bhxhAmount ?? 0)),
                              _PayslipRow('(14) BHYT', _formatCurrency(payslip.bhytAmount ?? 0)),
                              _PayslipRow('(15) BHTN', _formatCurrency(payslip.bhtnAmount ?? 0)),
                              _PayslipRow(
                                '(16) Tổng bảo hiểm = (13) + (14) + (15)',
                                _formatCurrency(
                                  (payslip.bhxhAmount ?? 0) +
                                  (payslip.bhytAmount ?? 0) +
                                  (payslip.bhtnAmount ?? 0),
                                ),
                                isBold: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // IV. Thuế thu nhập cá nhân
                          _buildSection(
                            context,
                            'IV. THUẾ THU NHẬP CÁ NHÂN (PIT)',
                            [
                              _PayslipRow('(17) Thu nhập chịu thuế = (4) + (5) + (6) + (9)', _formatCurrency(payslip.taxableIncome ?? 0)),
                              _PayslipRow('(18) Giảm trừ cá nhân', _formatCurrency(payslip.deductionPersonal ?? 0)),
                              _PayslipRow('(19) Giảm trừ người phụ thuộc', _formatCurrency(payslip.deductionDependents ?? 0)),
                              _PayslipRow('(20) Giảm trừ cố định', _formatCurrency(payslip.taxFixedDeduction ?? 0)),
                              _PayslipRow('(21) Tổng giảm trừ = (18) + (19) + (20)', _formatCurrency(payslip.totalDeductions ?? 0)),
                              _PayslipRow('(22) Thu nhập tính thuế = (17) - (21)', _formatCurrency(payslip.assessableIncome ?? 0), isBold: true),
                              _PayslipRow('(23) Thuế suất áp dụng', '${((payslip.taxRate ?? 0).toStringAsFixed(2))}%', isBold: true),
                              _PayslipRow('(24) Tiền thuế phải nộp = (22) * (23) - (20)', _formatCurrency(payslip.taxAmount ?? 0), isBold: true),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // V. Kết quả cuối cùng
                          _buildSection(
                            context,
                            'V. KẾT QUẢ CUỐI CÙNG',
                            [
                              _PayslipRow('Thực nhận = (7) + (8) + (10) + (17) - (24)', _formatCurrency(payslip.netSalary ?? 0), isBold: true, isHighlight: true),
                            ],
                            backgroundColor: Colors.green.shade50,
                          ),
                          const SizedBox(height: 24),

                          // Export PDF Button
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Get.snackbar('Thông báo', 'Tính năng sẽ sớm có');
                              },
                              icon: const Icon(Icons.download),
                              label: const Text('Tải về PDF'),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const Card(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                    error: (error, stackTrace) => Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text('Lỗi: $error'),
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const Card(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                error: (error, stackTrace) => Card(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Lỗi: $error'),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<_PayslipRow> rows, {
    Color? backgroundColor,
  }) {
    return Card(
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...rows.map((row) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: _buildPayslipRow(row),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPayslipRow(_PayslipRow row) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            row.label,
            style: TextStyle(
              fontWeight: row.isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            row.value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: row.isBold ? FontWeight.bold : FontWeight.normal,
              color: row.isHighlight ? Colors.green : Colors.black,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  String _formatCurrency(double? amount) {
    final formatter = _NumberFormatter();
    return formatter.format(amount ?? 0);
  }

  String _formatInt(double? value) {
    return (value ?? 0).toInt().toString();
  }

  String _safeString(String? value) {
    if (value == null || value.isEmpty) {
      return 'N/A';
    }
    return value;
  }
}

class _PayslipRow {
  final String label;
  final String value;
  final bool isBold;
  final bool isHighlight;

  _PayslipRow(
    this.label,
    this.value, {
    this.isBold = false,
    this.isHighlight = false,
  });
}

class _NumberFormatter {
  String format(double amount) {
    final absAmount = amount.abs();
    final isNegative = amount < 0;
    
    // Convert to integer string to avoid floating point issues
    final intAmount = absAmount.toStringAsFixed(0);
    
    // Add dots for thousands separator (Vietnamese format: 1.000 = 1000)
    // Using regex to insert '.' every 3 digits from the right
    final formatted = intAmount.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (Match m) => '.',
    );
    
    return '${isNegative ? '-' : ''}$formatted ₫';
  }
}
