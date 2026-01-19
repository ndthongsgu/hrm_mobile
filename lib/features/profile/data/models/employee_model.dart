import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

@freezed
class Employee with _$Employee {
  const factory Employee({
    required String id,
    required String fullName,
    required String email,
    String? phoneNumber,
    required DateTime dateOfBirth,
    required String gender,
    String? address,
    required String position,
    required String department,
    required DateTime hireDate,
    String? avatarUrl,
    required String status, // 'active', 'inactive', 'resigned'
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}

@freezed
class EmployeeDetail with _$EmployeeDetail {
  const factory EmployeeDetail({
    required Employee employee,
    String? bankAccount,
    String? bankName,
    String? taxCode,
    String? insuranceNumber,
    String? emergencyContact,
    String? emergencyPhone,
    String? qualifications,
  }) = _EmployeeDetail;

  factory EmployeeDetail.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDetailFromJson(json);
}
