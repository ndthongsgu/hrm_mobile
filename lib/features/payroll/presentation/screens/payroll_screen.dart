import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrm_mobile/config/theme.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  String? _selectedMonth = '01/2024';

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
          DropdownButton<String>(
            isExpanded: true,
            value: _selectedMonth,
            items: [
              '01/2024',
              '12/2023',
              '11/2023',
              '10/2023',
            ]
                .map((month) => DropdownMenuItem(
                      value: month,
                      child: Text(month),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedMonth = value);
            },
          ),
          const SizedBox(height: 24),

          // Salary summary card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tóm tắt lương tháng 01/2024',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildSalarySummaryRow('Lương cơ bản', '10.000.000 ₫'),
                  _buildSalarySummaryRow('Phụ cấp', '2.000.000 ₫'),
                  _buildSalarySummaryRow('Thưởng', '500.000 ₫'),
                  const Divider(height: 16),
                  _buildSalarySummaryRow('Tổng phải trả', '12.500.000 ₫',
                      isBold: true),
                  const SizedBox(height: 16),
                  _buildSalarySummaryRow('BHXH (8%)', '-800.000 ₫',
                      isNegative: true),
                  _buildSalarySummaryRow('Thuế TNCN', '-1.000.000 ₫',
                      isNegative: true),
                  _buildSalarySummaryRow('Khoản khác', '-500.000 ₫',
                      isNegative: true),
                  const Divider(height: 16),
                  _buildSalarySummaryRow('Lương thực nhận', '10.200.000 ₫',
                      isBold: true, isHighlight: true),
                ],
              ),
            ),
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
          const SizedBox(height: 24),

          // Salary details
          Text(
            'Chi tiết lương',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildDetailItem('Lương cơ bản', '10.000.000 ₫'),
          _buildDetailItem('Phụ cấp chức vụ', '1.000.000 ₫'),
          _buildDetailItem('Phụ cấp khác', '1.000.000 ₫'),
          _buildDetailItem('Thưởng hiệu suất', '500.000 ₫'),
          _buildDetailItem('BHXH', '-800.000 ₫'),
          _buildDetailItem('Thuế thu nhập cá nhân', '-1.000.000 ₫'),
          const SizedBox(height: 16),
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
            color: isHighlight
                ? Colors.green
                : isNegative
                    ? Colors.red
                    : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
