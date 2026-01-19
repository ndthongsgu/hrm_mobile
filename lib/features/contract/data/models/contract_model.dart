import 'package:freezed_annotation/freezed_annotation.dart';

part 'contract_model.freezed.dart';
part 'contract_model.g.dart';

@freezed
class EmployeeContract with _$EmployeeContract {
  const factory EmployeeContract({
    required String id,
    required String employeeId,
    required String contractType, // 'probation', 'fixed_term', 'indefinite'
    required DateTime startDate,
    DateTime? endDate,
    required double salary,
    String? position,
    String? department,
    String? workingLocation,
    String? contractDocument, // URL or path to document
    String? status, // 'draft', 'active', 'ended', 'terminated'
    String? notes,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EmployeeContract;

  factory EmployeeContract.fromJson(Map<String, dynamic> json) =>
      _$EmployeeContractFromJson(json);
}

@freezed
class SalaryStructure with _$SalaryStructure {
  const factory SalaryStructure({
    required String id,
    required String employeeId,
    required double basicSalary,
    required double allowance,
    required double bonus,
    required double deductions,
    required double bhxh, // Social insurance rate (8%)
    required double taxAmount,
    required double netSalary,
    required DateTime effectiveDate,
    required DateTime updatedAt,
  }) = _SalaryStructure;

  factory SalaryStructure.fromJson(Map<String, dynamic> json) =>
      _$SalaryStructureFromJson(json);
}
