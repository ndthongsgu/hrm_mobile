// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeContractImpl _$$EmployeeContractImplFromJson(
        Map<String, dynamic> json) =>
    _$EmployeeContractImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      contractType: json['contractType'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      salary: (json['salary'] as num).toDouble(),
      position: json['position'] as String?,
      department: json['department'] as String?,
      workingLocation: json['workingLocation'] as String?,
      contractDocument: json['contractDocument'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EmployeeContractImplToJson(
        _$EmployeeContractImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'contractType': instance.contractType,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'salary': instance.salary,
      'position': instance.position,
      'department': instance.department,
      'workingLocation': instance.workingLocation,
      'contractDocument': instance.contractDocument,
      'status': instance.status,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$SalaryStructureImpl _$$SalaryStructureImplFromJson(
        Map<String, dynamic> json) =>
    _$SalaryStructureImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      basicSalary: (json['basicSalary'] as num).toDouble(),
      allowance: (json['allowance'] as num).toDouble(),
      bonus: (json['bonus'] as num).toDouble(),
      deductions: (json['deductions'] as num).toDouble(),
      bhxh: (json['bhxh'] as num).toDouble(),
      taxAmount: (json['taxAmount'] as num).toDouble(),
      netSalary: (json['netSalary'] as num).toDouble(),
      effectiveDate: DateTime.parse(json['effectiveDate'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$SalaryStructureImplToJson(
        _$SalaryStructureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'basicSalary': instance.basicSalary,
      'allowance': instance.allowance,
      'bonus': instance.bonus,
      'deductions': instance.deductions,
      'bhxh': instance.bhxh,
      'taxAmount': instance.taxAmount,
      'netSalary': instance.netSalary,
      'effectiveDate': instance.effectiveDate.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
