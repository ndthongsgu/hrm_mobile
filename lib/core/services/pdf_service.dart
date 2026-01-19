import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../features/payroll/data/models/payroll_model.dart';
import 'package:intl/intl.dart';

class PDFService {
  final _dateFormat = DateFormat('dd/MM/yyyy');
  final _currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

  Future<void> generatePayrollPDF(Payroll payroll) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(30),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Column(
                  children: [
                    pw.Text(
                      'PHIẾU LƯƠNG THÁNG',
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Tháng ${payroll.month.toString().padLeft(2, '0')}/${payroll.year}',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Employee Info
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(),
                ),
                padding: const pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Thông tin nhân viên:',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text('Tên: ${payroll.employeeName}'),
                    pw.Text('Mã nhân viên: ${payroll.employeeId}'),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Salary details table
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Header row
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.grey300,
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Chi tiết lương',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          'Số tiền (₫)',
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          textAlign: pw.TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  // Data rows
                  _buildTableRow('Lương cơ bản', payroll.basicSalary),
                  _buildTableRow('Phụ cấp', payroll.allowance),
                  _buildTableRow('Thưởng', payroll.bonus),
                  _buildTableRow('Tổng cộng', payroll.basicSalary + payroll.allowance + payroll.bonus, isBold: true),
                  pw.TableRow(
                    children: [
                      pw.Divider(),
                      pw.Divider(),
                    ],
                  ),
                  _buildTableRow('BHXH (8%)', payroll.bhxh),
                  _buildTableRow('Thuế TNCN', payroll.personalIncomeTax),
                  _buildTableRow('Các khoản khác', payroll.otherDeductions),
                  _buildTableRow('Tổng cộng giảm trừ', payroll.totalDeductions, isBold: true),
                  pw.TableRow(
                    children: [
                      pw.Divider(),
                      pw.Divider(),
                    ],
                  ),
                  _buildTableRow(
                    'Lương thực nhận',
                    payroll.netSalary,
                    isBold: true,
                    isHighlight: true,
                  ),
                ],
              ),
              pw.SizedBox(height: 20),

              // Notes
              if (payroll.notes != null && payroll.notes!.isNotEmpty)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Ghi chú:',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                    pw.Text(payroll.notes!),
                    pw.SizedBox(height: 20),
                  ],
                ),

              // Footer
              pw.Spacer(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 40),
                      pw.Text(
                        'Nhân viên HR',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 40),
                      pw.Text(
                        'Quản lý',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.SizedBox(height: 40),
                      pw.Text(
                        'Giám đốc',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Ngày in: ${_dateFormat.format(DateTime.now())}',
                style: const pw.TextStyle(fontSize: 9),
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename: 'payroll_${payroll.employeeName}_${payroll.month}_${payroll.year}.pdf',
    );
  }

  pw.TableRow _buildTableRow(
    String label,
    double value, {
    bool isBold = false,
    bool isHighlight = false,
  }) {
    return pw.TableRow(
      decoration: isHighlight
          ? const pw.BoxDecoration(color: PdfColors.yellow100)
          : null,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            label,
            style: isBold ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null,
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            _currencyFormat.format(value),
            textAlign: pw.TextAlign.right,
            style: isBold ? pw.TextStyle(fontWeight: pw.FontWeight.bold) : null,
          ),
        ),
      ],
    );
  }

  Future<void> generateMultiplePayrollsPDF(List<Payroll> payrolls) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return pw.Column(
            children: [
              pw.Center(
                child: pw.Text(
                  'BẢNG LƯƠNG THÁNG ${payrolls.first.month.toString().padLeft(2, '0')}/${payrolls.first.year}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 15),
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1.5),
                  2: const pw.FlexColumnWidth(1.5),
                  3: const pw.FlexColumnWidth(1.5),
                  4: const pw.FlexColumnWidth(1.5),
                  5: const pw.FlexColumnWidth(1.5),
                },
                children: [
                  // Header
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.grey300),
                    children: [
                      _buildHeaderCell('Tên nhân viên'),
                      _buildHeaderCell('Lương cơ bản'),
                      _buildHeaderCell('Phụ cấp'),
                      _buildHeaderCell('BHXH'),
                      _buildHeaderCell('Thuế'),
                      _buildHeaderCell('Lương thực'),
                    ],
                  ),
                  // Data rows
                  ...payrolls.map((payroll) {
                    return pw.TableRow(
                      children: [
                        _buildDataCell(payroll.employeeName),
                        _buildDataCell(_currencyFormat.format(payroll.basicSalary)),
                        _buildDataCell(_currencyFormat.format(payroll.allowance)),
                        _buildDataCell(_currencyFormat.format(payroll.bhxh)),
                        _buildDataCell(_currencyFormat.format(payroll.personalIncomeTax)),
                        _buildDataCell(
                          _currencyFormat.format(payroll.netSalary),
                          isBold: true,
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.sharePdf(
      bytes: await pdf.save(),
      filename:
          'payroll_list_${payrolls.first.month}_${payrolls.first.year}.pdf',
    );
  }

  pw.Widget _buildHeaderCell(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  pw.Widget _buildDataCell(String text, {bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        textAlign: pw.TextAlign.right,
        style: pw.TextStyle(
          fontSize: 9,
          fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      ),
    );
  }
}
