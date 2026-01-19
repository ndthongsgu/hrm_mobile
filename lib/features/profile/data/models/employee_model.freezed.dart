// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Employee _$EmployeeFromJson(Map<String, dynamic> json) {
  return _Employee.fromJson(json);
}

/// @nodoc
mixin _$Employee {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  DateTime get hireDate => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'active', 'inactive', 'resigned'
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeCopyWith<Employee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeCopyWith<$Res> {
  factory $EmployeeCopyWith(Employee value, $Res Function(Employee) then) =
      _$EmployeeCopyWithImpl<$Res, Employee>;
  @useResult
  $Res call(
      {String id,
      String fullName,
      String email,
      String? phoneNumber,
      DateTime dateOfBirth,
      String gender,
      String? address,
      String position,
      String department,
      DateTime hireDate,
      String? avatarUrl,
      String status,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$EmployeeCopyWithImpl<$Res, $Val extends Employee>
    implements $EmployeeCopyWith<$Res> {
  _$EmployeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? dateOfBirth = null,
    Object? gender = null,
    Object? address = freezed,
    Object? position = null,
    Object? department = null,
    Object? hireDate = null,
    Object? avatarUrl = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      hireDate: null == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmployeeImplCopyWith<$Res>
    implements $EmployeeCopyWith<$Res> {
  factory _$$EmployeeImplCopyWith(
          _$EmployeeImpl value, $Res Function(_$EmployeeImpl) then) =
      __$$EmployeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String fullName,
      String email,
      String? phoneNumber,
      DateTime dateOfBirth,
      String gender,
      String? address,
      String position,
      String department,
      DateTime hireDate,
      String? avatarUrl,
      String status,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$EmployeeImplCopyWithImpl<$Res>
    extends _$EmployeeCopyWithImpl<$Res, _$EmployeeImpl>
    implements _$$EmployeeImplCopyWith<$Res> {
  __$$EmployeeImplCopyWithImpl(
      _$EmployeeImpl _value, $Res Function(_$EmployeeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? email = null,
    Object? phoneNumber = freezed,
    Object? dateOfBirth = null,
    Object? gender = null,
    Object? address = freezed,
    Object? position = null,
    Object? department = null,
    Object? hireDate = null,
    Object? avatarUrl = freezed,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$EmployeeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      hireDate: null == hireDate
          ? _value.hireDate
          : hireDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeImpl implements _Employee {
  const _$EmployeeImpl(
      {required this.id,
      required this.fullName,
      required this.email,
      this.phoneNumber,
      required this.dateOfBirth,
      required this.gender,
      this.address,
      required this.position,
      required this.department,
      required this.hireDate,
      this.avatarUrl,
      required this.status,
      required this.createdAt,
      required this.updatedAt});

  factory _$EmployeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String email;
  @override
  final String? phoneNumber;
  @override
  final DateTime dateOfBirth;
  @override
  final String gender;
  @override
  final String? address;
  @override
  final String position;
  @override
  final String department;
  @override
  final DateTime hireDate;
  @override
  final String? avatarUrl;
  @override
  final String status;
// 'active', 'inactive', 'resigned'
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Employee(id: $id, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, gender: $gender, address: $address, position: $position, department: $department, hireDate: $hireDate, avatarUrl: $avatarUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.hireDate, hireDate) ||
                other.hireDate == hireDate) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      fullName,
      email,
      phoneNumber,
      dateOfBirth,
      gender,
      address,
      position,
      department,
      hireDate,
      avatarUrl,
      status,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeImplCopyWith<_$EmployeeImpl> get copyWith =>
      __$$EmployeeImplCopyWithImpl<_$EmployeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeImplToJson(
      this,
    );
  }
}

abstract class _Employee implements Employee {
  const factory _Employee(
      {required final String id,
      required final String fullName,
      required final String email,
      final String? phoneNumber,
      required final DateTime dateOfBirth,
      required final String gender,
      final String? address,
      required final String position,
      required final String department,
      required final DateTime hireDate,
      final String? avatarUrl,
      required final String status,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$EmployeeImpl;

  factory _Employee.fromJson(Map<String, dynamic> json) =
      _$EmployeeImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get email;
  @override
  String? get phoneNumber;
  @override
  DateTime get dateOfBirth;
  @override
  String get gender;
  @override
  String? get address;
  @override
  String get position;
  @override
  String get department;
  @override
  DateTime get hireDate;
  @override
  String? get avatarUrl;
  @override
  String get status;
  @override // 'active', 'inactive', 'resigned'
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeImplCopyWith<_$EmployeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EmployeeDetail _$EmployeeDetailFromJson(Map<String, dynamic> json) {
  return _EmployeeDetail.fromJson(json);
}

/// @nodoc
mixin _$EmployeeDetail {
  Employee get employee => throw _privateConstructorUsedError;
  String? get bankAccount => throw _privateConstructorUsedError;
  String? get bankName => throw _privateConstructorUsedError;
  String? get taxCode => throw _privateConstructorUsedError;
  String? get insuranceNumber => throw _privateConstructorUsedError;
  String? get emergencyContact => throw _privateConstructorUsedError;
  String? get emergencyPhone => throw _privateConstructorUsedError;
  String? get qualifications => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeDetailCopyWith<EmployeeDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeDetailCopyWith<$Res> {
  factory $EmployeeDetailCopyWith(
          EmployeeDetail value, $Res Function(EmployeeDetail) then) =
      _$EmployeeDetailCopyWithImpl<$Res, EmployeeDetail>;
  @useResult
  $Res call(
      {Employee employee,
      String? bankAccount,
      String? bankName,
      String? taxCode,
      String? insuranceNumber,
      String? emergencyContact,
      String? emergencyPhone,
      String? qualifications});

  $EmployeeCopyWith<$Res> get employee;
}

/// @nodoc
class _$EmployeeDetailCopyWithImpl<$Res, $Val extends EmployeeDetail>
    implements $EmployeeDetailCopyWith<$Res> {
  _$EmployeeDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? bankAccount = freezed,
    Object? bankName = freezed,
    Object? taxCode = freezed,
    Object? insuranceNumber = freezed,
    Object? emergencyContact = freezed,
    Object? emergencyPhone = freezed,
    Object? qualifications = freezed,
  }) {
    return _then(_value.copyWith(
      employee: null == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as Employee,
      bankAccount: freezed == bankAccount
          ? _value.bankAccount
          : bankAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      taxCode: freezed == taxCode
          ? _value.taxCode
          : taxCode // ignore: cast_nullable_to_non_nullable
              as String?,
      insuranceNumber: freezed == insuranceNumber
          ? _value.insuranceNumber
          : insuranceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyPhone: freezed == emergencyPhone
          ? _value.emergencyPhone
          : emergencyPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      qualifications: freezed == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EmployeeCopyWith<$Res> get employee {
    return $EmployeeCopyWith<$Res>(_value.employee, (value) {
      return _then(_value.copyWith(employee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EmployeeDetailImplCopyWith<$Res>
    implements $EmployeeDetailCopyWith<$Res> {
  factory _$$EmployeeDetailImplCopyWith(_$EmployeeDetailImpl value,
          $Res Function(_$EmployeeDetailImpl) then) =
      __$$EmployeeDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Employee employee,
      String? bankAccount,
      String? bankName,
      String? taxCode,
      String? insuranceNumber,
      String? emergencyContact,
      String? emergencyPhone,
      String? qualifications});

  @override
  $EmployeeCopyWith<$Res> get employee;
}

/// @nodoc
class __$$EmployeeDetailImplCopyWithImpl<$Res>
    extends _$EmployeeDetailCopyWithImpl<$Res, _$EmployeeDetailImpl>
    implements _$$EmployeeDetailImplCopyWith<$Res> {
  __$$EmployeeDetailImplCopyWithImpl(
      _$EmployeeDetailImpl _value, $Res Function(_$EmployeeDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? employee = null,
    Object? bankAccount = freezed,
    Object? bankName = freezed,
    Object? taxCode = freezed,
    Object? insuranceNumber = freezed,
    Object? emergencyContact = freezed,
    Object? emergencyPhone = freezed,
    Object? qualifications = freezed,
  }) {
    return _then(_$EmployeeDetailImpl(
      employee: null == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as Employee,
      bankAccount: freezed == bankAccount
          ? _value.bankAccount
          : bankAccount // ignore: cast_nullable_to_non_nullable
              as String?,
      bankName: freezed == bankName
          ? _value.bankName
          : bankName // ignore: cast_nullable_to_non_nullable
              as String?,
      taxCode: freezed == taxCode
          ? _value.taxCode
          : taxCode // ignore: cast_nullable_to_non_nullable
              as String?,
      insuranceNumber: freezed == insuranceNumber
          ? _value.insuranceNumber
          : insuranceNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyContact: freezed == emergencyContact
          ? _value.emergencyContact
          : emergencyContact // ignore: cast_nullable_to_non_nullable
              as String?,
      emergencyPhone: freezed == emergencyPhone
          ? _value.emergencyPhone
          : emergencyPhone // ignore: cast_nullable_to_non_nullable
              as String?,
      qualifications: freezed == qualifications
          ? _value.qualifications
          : qualifications // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmployeeDetailImpl implements _EmployeeDetail {
  const _$EmployeeDetailImpl(
      {required this.employee,
      this.bankAccount,
      this.bankName,
      this.taxCode,
      this.insuranceNumber,
      this.emergencyContact,
      this.emergencyPhone,
      this.qualifications});

  factory _$EmployeeDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeDetailImplFromJson(json);

  @override
  final Employee employee;
  @override
  final String? bankAccount;
  @override
  final String? bankName;
  @override
  final String? taxCode;
  @override
  final String? insuranceNumber;
  @override
  final String? emergencyContact;
  @override
  final String? emergencyPhone;
  @override
  final String? qualifications;

  @override
  String toString() {
    return 'EmployeeDetail(employee: $employee, bankAccount: $bankAccount, bankName: $bankName, taxCode: $taxCode, insuranceNumber: $insuranceNumber, emergencyContact: $emergencyContact, emergencyPhone: $emergencyPhone, qualifications: $qualifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeDetailImpl &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.bankAccount, bankAccount) ||
                other.bankAccount == bankAccount) &&
            (identical(other.bankName, bankName) ||
                other.bankName == bankName) &&
            (identical(other.taxCode, taxCode) || other.taxCode == taxCode) &&
            (identical(other.insuranceNumber, insuranceNumber) ||
                other.insuranceNumber == insuranceNumber) &&
            (identical(other.emergencyContact, emergencyContact) ||
                other.emergencyContact == emergencyContact) &&
            (identical(other.emergencyPhone, emergencyPhone) ||
                other.emergencyPhone == emergencyPhone) &&
            (identical(other.qualifications, qualifications) ||
                other.qualifications == qualifications));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      employee,
      bankAccount,
      bankName,
      taxCode,
      insuranceNumber,
      emergencyContact,
      emergencyPhone,
      qualifications);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeDetailImplCopyWith<_$EmployeeDetailImpl> get copyWith =>
      __$$EmployeeDetailImplCopyWithImpl<_$EmployeeDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeDetailImplToJson(
      this,
    );
  }
}

abstract class _EmployeeDetail implements EmployeeDetail {
  const factory _EmployeeDetail(
      {required final Employee employee,
      final String? bankAccount,
      final String? bankName,
      final String? taxCode,
      final String? insuranceNumber,
      final String? emergencyContact,
      final String? emergencyPhone,
      final String? qualifications}) = _$EmployeeDetailImpl;

  factory _EmployeeDetail.fromJson(Map<String, dynamic> json) =
      _$EmployeeDetailImpl.fromJson;

  @override
  Employee get employee;
  @override
  String? get bankAccount;
  @override
  String? get bankName;
  @override
  String? get taxCode;
  @override
  String? get insuranceNumber;
  @override
  String? get emergencyContact;
  @override
  String? get emergencyPhone;
  @override
  String? get qualifications;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeDetailImplCopyWith<_$EmployeeDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
