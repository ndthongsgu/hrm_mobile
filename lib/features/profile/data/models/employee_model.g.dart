// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EmployeeImpl _$$EmployeeImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeImpl(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String,
      address: json['address'] as String?,
      position: json['position'] as String,
      department: json['department'] as String,
      hireDate: DateTime.parse(json['hireDate'] as String),
      avatarUrl: json['avatarUrl'] as String?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$EmployeeImplToJson(_$EmployeeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth.toIso8601String(),
      'gender': instance.gender,
      'address': instance.address,
      'position': instance.position,
      'department': instance.department,
      'hireDate': instance.hireDate.toIso8601String(),
      'avatarUrl': instance.avatarUrl,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$EmployeeDetailImpl _$$EmployeeDetailImplFromJson(Map<String, dynamic> json) =>
    _$EmployeeDetailImpl(
      employee: Employee.fromJson(json['employee'] as Map<String, dynamic>),
      bankAccount: json['bankAccount'] as String?,
      bankName: json['bankName'] as String?,
      taxCode: json['taxCode'] as String?,
      insuranceNumber: json['insuranceNumber'] as String?,
      emergencyContact: json['emergencyContact'] as String?,
      emergencyPhone: json['emergencyPhone'] as String?,
      qualifications: json['qualifications'] as String?,
    );

Map<String, dynamic> _$$EmployeeDetailImplToJson(
        _$EmployeeDetailImpl instance) =>
    <String, dynamic>{
      'employee': instance.employee,
      'bankAccount': instance.bankAccount,
      'bankName': instance.bankName,
      'taxCode': instance.taxCode,
      'insuranceNumber': instance.insuranceNumber,
      'emergencyContact': instance.emergencyContact,
      'emergencyPhone': instance.emergencyPhone,
      'qualifications': instance.qualifications,
    };
