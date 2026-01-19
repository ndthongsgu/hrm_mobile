import 'package:freezed_annotation/freezed_annotation.dart';

part 'payroll_model.freezed.dart';
part 'payroll_model.g.dart';

@freezed
class Payroll with _$Payroll {
  const factory Payroll({
    required String id,
    required String employeeId,
    required String employeeName,
    required int month,
    required int year,
    required double basicSalary,
    required double allowance,
    required double bonus,
    required double bhxh, // Social insurance (8% of basic salary)
    required double personalIncomeTax,
    required double otherDeductions,
    required double totalDeductions,
    required double netSalary,
    required String status, // 'draft', 'pending_approval', 'approved', 'paid'
    String? notes,
    String? pdfUrl,
    required DateTime createdAt,
    DateTime? paidDate,
    required DateTime updatedAt,
  }) = _Payroll;

  factory Payroll.fromJson(Map<String, dynamic> json) =>
      _$PayrollFromJson(json);
}

@freezed
class PayrollSummary with _$PayrollSummary {
  const factory PayrollSummary({
    required int month,
    required int year,
    required int totalEmployees,
    required int processedPayroll,
    required double totalBasicSalary,
    required double totalAllowances,
    required double totalDeductions,
    required double totalNetSalary,
    required String status,
    required DateTime createdAt,
  }) = _PayrollSummary;

  factory PayrollSummary.fromJson(Map<String, dynamic> json) =>
      _$PayrollSummaryFromJson(json);
}

class TaxCalculation {
  // Vietnam personal income tax brackets (2024)
  static const double taxFreeAmount = 11000000; // 11 million VND

  static double calculatePersonalIncomeTax(double monthlyIncome) {
    if (monthlyIncome <= taxFreeAmount) {
      return 0;
    }

    double taxableIncome = monthlyIncome - taxFreeAmount;

    // Tax brackets: 5%, 10%, 15%, 20%, 25%, 30%, 35%
    if (taxableIncome <= 5000000) {
      return taxableIncome * 0.05;
    } else if (taxableIncome <= 10000000) {
      return 5000000 * 0.05 + (taxableIncome - 5000000) * 0.10;
    } else if (taxableIncome <= 18000000) {
      return 5000000 * 0.05 +
          5000000 * 0.10 +
          (taxableIncome - 10000000) * 0.15;
    } else if (taxableIncome <= 32000000) {
      return 5000000 * 0.05 +
          5000000 * 0.10 +
          8000000 * 0.15 +
          (taxableIncome - 18000000) * 0.20;
    } else if (taxableIncome <= 52000000) {
      return 5000000 * 0.05 +
          5000000 * 0.10 +
          8000000 * 0.15 +
          14000000 * 0.20 +
          (taxableIncome - 32000000) * 0.25;
    } else if (taxableIncome <= 80000000) {
      return 5000000 * 0.05 +
          5000000 * 0.10 +
          8000000 * 0.15 +
          14000000 * 0.20 +
          20000000 * 0.25 +
          (taxableIncome - 52000000) * 0.30;
    } else {
      return 5000000 * 0.05 +
          5000000 * 0.10 +
          8000000 * 0.15 +
          14000000 * 0.20 +
          20000000 * 0.25 +
          28000000 * 0.30 +
          (taxableIncome - 80000000) * 0.35;
    }
  }

  // BHXH = 8% of basic salary (Vietnam social insurance)
  static double calculateBHXH(double basicSalary) {
    return basicSalary * 0.08;
  }

  // Calculate net salary
  static double calculateNetSalary({
    required double basicSalary,
    required double allowance,
    required double bonus,
    required double bhxh,
    required double tax,
    required double otherDeductions,
  }) {
    return basicSalary + allowance + bonus - bhxh - tax - otherDeductions;
  }
}
