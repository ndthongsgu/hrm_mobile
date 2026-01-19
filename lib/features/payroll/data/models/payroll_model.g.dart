// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payroll_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PayrollImpl _$$PayrollImplFromJson(Map<String, dynamic> json) =>
    _$PayrollImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      employeeName: json['employeeName'] as String,
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      basicSalary: (json['basicSalary'] as num).toDouble(),
      allowance: (json['allowance'] as num).toDouble(),
      bonus: (json['bonus'] as num).toDouble(),
      bhxh: (json['bhxh'] as num).toDouble(),
      personalIncomeTax: (json['personalIncomeTax'] as num).toDouble(),
      otherDeductions: (json['otherDeductions'] as num).toDouble(),
      totalDeductions: (json['totalDeductions'] as num).toDouble(),
      netSalary: (json['netSalary'] as num).toDouble(),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      pdfUrl: json['pdfUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      paidDate: json['paidDate'] == null
          ? null
          : DateTime.parse(json['paidDate'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PayrollImplToJson(_$PayrollImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'employeeName': instance.employeeName,
      'month': instance.month,
      'year': instance.year,
      'basicSalary': instance.basicSalary,
      'allowance': instance.allowance,
      'bonus': instance.bonus,
      'bhxh': instance.bhxh,
      'personalIncomeTax': instance.personalIncomeTax,
      'otherDeductions': instance.otherDeductions,
      'totalDeductions': instance.totalDeductions,
      'netSalary': instance.netSalary,
      'status': instance.status,
      'notes': instance.notes,
      'pdfUrl': instance.pdfUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'paidDate': instance.paidDate?.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$PayrollSummaryImpl _$$PayrollSummaryImplFromJson(Map<String, dynamic> json) =>
    _$PayrollSummaryImpl(
      month: (json['month'] as num).toInt(),
      year: (json['year'] as num).toInt(),
      totalEmployees: (json['totalEmployees'] as num).toInt(),
      processedPayroll: (json['processedPayroll'] as num).toInt(),
      totalBasicSalary: (json['totalBasicSalary'] as num).toDouble(),
      totalAllowances: (json['totalAllowances'] as num).toDouble(),
      totalDeductions: (json['totalDeductions'] as num).toDouble(),
      totalNetSalary: (json['totalNetSalary'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$PayrollSummaryImplToJson(
        _$PayrollSummaryImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
      'totalEmployees': instance.totalEmployees,
      'processedPayroll': instance.processedPayroll,
      'totalBasicSalary': instance.totalBasicSalary,
      'totalAllowances': instance.totalAllowances,
      'totalDeductions': instance.totalDeductions,
      'totalNetSalary': instance.totalNetSalary,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
    };
