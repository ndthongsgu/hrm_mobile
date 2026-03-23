class PayslipModel {
  final String id;
  final String payrollPeriodId;
  final String payrollPeriodName;
  final String employeeId;
  final String employeeName;
  final String employeeCode;
  final String contractId;
  final String? createdBy;
  final String status;
  
  // Income
  final double? grossSalary;
  final double? totalWorkdays;
  final double? workdays;
  final double? salaryByWorkdays;
  final double? taxableAndInsurableAllowance;
  final double? taxableAndNonInsurableAllowance;
  final double? nonTaxableAndInsurableAllowance;
  final double? nonTaxableAndNonInsurableAllowance;
  final double? totalAllowance;
  final double? totalBonus;
  final double? totalBonusNonTax;
  
  // Insurance
  final double? bhxhSalaryBase;
  final double? bhxhAmount;
  final double? bhytAmount;
  final double? bhtnAmount;
  
  // Tax
  final double? taxableIncome;
  final double? deductionPersonal;
  final double? deductionDependents;
  final double? taxFixedDeduction;
  final double? totalDeductions;
  final double? assessableIncome;
  final double? taxRate;
  final double? taxAmount;
  
  // Net
  final double? netSalary;

  PayslipModel({
    required this.id,
    required this.payrollPeriodId,
    required this.payrollPeriodName,
    required this.employeeId,
    required this.employeeName,
    required this.employeeCode,
    required this.contractId,
    this.createdBy,
    required this.status,
    this.grossSalary,
    this.totalWorkdays,
    this.workdays,
    this.salaryByWorkdays,
    this.taxableAndInsurableAllowance,
    this.taxableAndNonInsurableAllowance,
    this.nonTaxableAndInsurableAllowance,
    this.nonTaxableAndNonInsurableAllowance,
    this.totalAllowance,
    this.totalBonus,
    this.totalBonusNonTax,
    this.bhxhSalaryBase,
    this.bhxhAmount,
    this.bhytAmount,
    this.bhtnAmount,
    this.taxableIncome,
    this.deductionPersonal,
    this.deductionDependents,
    this.taxFixedDeduction,
    this.totalDeductions,
    this.assessableIncome,
    this.taxRate,
    this.taxAmount,
    this.netSalary,
  });

  factory PayslipModel.fromJson(Map<String, dynamic> json) {
    return PayslipModel(
      id: json['id'] as String? ?? '',
      payrollPeriodId: json['payrollPeriod']?['id'] as String? ?? '',
      payrollPeriodName: json['payrollPeriod']?['name'] as String? ?? '',
      employeeId: json['employee']?['id'] as String? ?? '',
      employeeName: json['employee']?['fullName'] as String? ?? '',
      employeeCode: json['employee']?['employeeCode'] as String? ?? '',
      contractId: json['contract']?['id'] as String? ?? '',
      createdBy: json['createBy'] as String?,
      status: json['status'] as String? ?? 'PENDING',
      grossSalary: _parseDouble(json['grossSalary']),
      totalWorkdays: _parseDouble(json['totalWorkdays']),
      workdays: _parseDouble(json['workdays']),
      salaryByWorkdays: _parseDouble(json['salaryByWorkdays']),
      taxableAndInsurableAllowance: _parseDouble(json['taxableAndInsurableAllowance']),
      taxableAndNonInsurableAllowance: _parseDouble(json['taxableAndNonInsurableAllowance']),
      nonTaxableAndInsurableAllowance: _parseDouble(json['nonTaxableAndInsurableAllowance']),
      nonTaxableAndNonInsurableAllowance: _parseDouble(json['nonTaxableAndNonInsurableAllowance']),
      totalAllowance: _parseDouble(json['totalAllowance']),
      totalBonus: _parseDouble(json['totalBonus']),
      totalBonusNonTax: _parseDouble(json['totalBonusNonTax']),
      bhxhSalaryBase: _parseDouble(json['bhxhSalaryBase']),
      bhxhAmount: _parseDouble(json['bhxhAmount']),
      bhytAmount: _parseDouble(json['bhytAmount']),
      bhtnAmount: _parseDouble(json['bhtnAmount']),
      taxableIncome: _parseDouble(json['taxableIncome']),
      deductionPersonal: _parseDouble(json['deductionPersonal']),
      deductionDependents: _parseDouble(json['deductionDependents']),
      taxFixedDeduction: _parseDouble(json['taxFixedDeduction']),
      totalDeductions: _parseDouble(json['totalDeductions']),
      assessableIncome: _parseDouble(json['assessableIncome']),
      taxRate: _parseDouble(json['taxRate']),
      taxAmount: _parseDouble(json['taxAmount']),
      netSalary: _parseDouble(json['netSalary']),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
