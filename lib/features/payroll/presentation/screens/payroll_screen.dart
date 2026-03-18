import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hrm_mobile/config/theme.dart';
import '../../payroll_provider.dart';

class PayrollScreen extends ConsumerStatefulWidget {
  const PayrollScreen({super.key});

  @override
  ConsumerState<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends ConsumerState<PayrollScreen> {
  String? _selectedPeriodId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Bảng lương'),
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
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text('Error: $error'),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Salary summary card
          Consumer(
            builder: (context, ref, child) {
              final payrollPeriodsAsync = ref.watch(payrollPeriodsProvider);
              
              return payrollPeriodsAsync.when(
                data: (periods) {
                  final selectedPeriod = periods.firstWhereOrNull(
                    (p) => p.id == _selectedPeriodId,
                  ) ?? (periods.isNotEmpty ? periods.first : null);
                  
                  // Get employee ID from auth service via Riverpod
                  final authService = ref.watch(authServiceProvider);
                  final userData = authService.getUserData();
                  final employeeId = (userData?['employeeId'] as String?)?.trim();
                  
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
                  
                  // Fetch payslip data
                  final payslipAsync = ref.watch(payslipProvider(
                    (employeeId: employeeId, payrollPeriodId: selectedPeriod.id),
                  ));
                  
                  return payslipAsync.when(
                    data: (payslip) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // I. Thông tin cơ bản
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'I. Thông tin cơ bản',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSalarySummaryRow('Kỳ lương', selectedPeriod.name),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // II. Thu nhập
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'II. Thu nhập',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSalarySummaryRow(
                                    'Lương cơ sở',
                                    _formatCurrency(payslip.grossSalary ?? 0),
                                  ),
                                  _buildSalarySummaryRow(
                                    'Lương thanh toán theo công',
                                    _formatCurrency(payslip.salaryByWorkdays ?? 0),
                                  ),
                                  _buildSalarySummaryRow(
                                    'Tổng phụ cấp',
                                    _formatCurrency(payslip.totalAllowance ?? 0),
                                  ),
                                  _buildSalarySummaryRow(
                                    'Tổng thưởng',
                                    _formatCurrency(payslip.totalBonus ?? 0),
                                    color: (payslip.totalBonus ?? 0) >= 0 ? Colors.green : Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // III. Bảo hiểm xã hội
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'III. Bảo hiểm xã hội',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSalarySummaryRow(
                                    'BHXH',
                                    _formatCurrency(payslip.bhxhAmount ?? 0),
                                    isNegative: true,
                                  ),
                                  _buildSalarySummaryRow(
                                    'BHYT',
                                    _formatCurrency(payslip.bhytAmount ?? 0),
                                    isNegative: true,
                                  ),
                                  _buildSalarySummaryRow(
                                    'BHTN',
                                    _formatCurrency(payslip.bhtnAmount ?? 0),
                                    isNegative: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // IV. Thuế thu nhập cá nhân
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'IV. Thuế thu nhập cá nhân (PIT)',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildSalarySummaryRow(
                                    'Giảm trừ cá nhân',
                                    _formatCurrency(payslip.deductionPersonal ?? 0),
                                  ),
                                  _buildSalarySummaryRow(
                                    'Giảm trừ người phụ thuộc',
                                    _formatCurrency(payslip.deductionDependents ?? 0),
                                  ),
                                  _buildSalarySummaryRow(
                                    'Tiền thuế phải nộp',
                                    _formatCurrency(payslip.taxAmount ?? 0),
                                    isNegative: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // V. Kết quả
                          Card(
                            color: Colors.green.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'V. Kết quả',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lương ròng',
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        _formatCurrency(payslip.netSalary ?? 0),
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
                      child: Text('Error: $error'),
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),

          // Export PDF Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.snackbar('Thành công', 'PDF sẽ được tải xuống');
              },
              icon: const Icon(Icons.download),
              label: const Text('Tải về PDF'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalarySummaryRow(
    String label,
    String value, {
    bool isBold = false,
    bool isNegative = false,
    bool isHighlight = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color ?? (isHighlight
                ? Colors.green
                : isNegative
                    ? Colors.red
                    : Colors.black),
          ),
        ),
      ],
    );
  }


  String _formatCurrency(double amount) {
    final formatter = _NumberFormatter();
    return formatter.format(amount);
  }
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
