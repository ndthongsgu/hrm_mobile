class PayslipModel {
  final String id;
  final String payrollPeriodId;
  final String employeeId;
  final String contractId;
  
  // Income
  final double? grossSalary;
  final double? salaryByWorkdays;
  final double? totalAllowance;
  final double? totalBonus;
  
  // Insurance
  final double? bhxhAmount;
  final double? bhytAmount;
  final double? bhtnAmount;
  final double? socialInsuranceBenefitAmount;
  
  // Tax
  final double? taxableIncome;
  final double? deductionPersonal;
  final double? deductionDependents;
  final double? assessableIncome;
  final double? taxAmount;
  
  // Net
  final double? netSalary;
  
  final String status;

  PayslipModel({
    required this.id,
    required this.payrollPeriodId,
    required this.employeeId,
    required this.contractId,
    this.grossSalary,
    this.salaryByWorkdays,
    this.totalAllowance,
    this.totalBonus,
    this.bhxhAmount,
    this.bhytAmount,
    this.bhtnAmount,
    this.socialInsuranceBenefitAmount,
    this.taxableIncome,
    this.deductionPersonal,
    this.deductionDependents,
    this.assessableIncome,
    this.taxAmount,
    this.netSalary,
    required this.status,
  });

  factory PayslipModel.fromJson(Map<String, dynamic> json) {
    return PayslipModel(
      id: json['id'] as String? ?? '',
      payrollPeriodId: json['payrollPeriod']?['id'] as String? ?? '',
      employeeId: json['employee']?['id'] as String? ?? '',
      contractId: json['contract']?['id'] as String? ?? '',
      grossSalary: _parseDouble(json['grossSalary']),
      salaryByWorkdays: _parseDouble(json['salaryByWorkdays']),
      totalAllowance: _parseDouble(json['totalAllowance']),
      totalBonus: _parseDouble(json['totalBonus']),
      bhxhAmount: _parseDouble(json['bhxhAmount']),
      bhytAmount: _parseDouble(json['bhytAmount']),
      bhtnAmount: _parseDouble(json['bhtnAmount']),
      socialInsuranceBenefitAmount: _parseDouble(json['socialInsuranceBenefitAmount']),
      taxableIncome: _parseDouble(json['taxableIncome']),
      deductionPersonal: _parseDouble(json['deductionPersonal']),
      deductionDependents: _parseDouble(json['deductionDependents']),
      assessableIncome: _parseDouble(json['assessableIncome']),
      taxAmount: _parseDouble(json['taxAmount']),
      netSalary: _parseDouble(json['netSalary']),
      status: json['status'] as String? ?? 'PENDING',
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  // Helper to calculate total income
  double get totalIncome =>
      (grossSalary ?? 0) + (totalAllowance ?? 0) + (totalBonus ?? 0);

  // Helper to calculate total deductions
  double get totalDeductions =>
      (bhxhAmount ?? 0) +
      (bhytAmount ?? 0) +
      (bhtnAmount ?? 0) +
      (taxAmount ?? 0);
}
