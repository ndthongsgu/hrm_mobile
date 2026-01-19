// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EmployeeContract _$EmployeeContractFromJson(Map<String, dynamic> json) {
  return _EmployeeContract.fromJson(json);
}

/// @nodoc
mixin _$EmployeeContract {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get contractType =>
      throw _privateConstructorUsedError; // 'probation', 'fixed_term', 'indefinite'
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  double get salary => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get workingLocation => throw _privateConstructorUsedError;
  String? get contractDocument =>
      throw _privateConstructorUsedError; // URL or path to document
  String? get status =>
      throw _privateConstructorUsedError; // 'draft', 'active', 'ended', 'terminated'
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmployeeContractCopyWith<EmployeeContract> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeContractCopyWith<$Res> {
  factory $EmployeeContractCopyWith(
          EmployeeContract value, $Res Function(EmployeeContract) then) =
      _$EmployeeContractCopyWithImpl<$Res, EmployeeContract>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String contractType,
      DateTime startDate,
      DateTime? endDate,
      double salary,
      String? position,
      String? department,
      String? workingLocation,
      String? contractDocument,
      String? status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$EmployeeContractCopyWithImpl<$Res, $Val extends EmployeeContract>
    implements $EmployeeContractCopyWith<$Res> {
  _$EmployeeContractCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? contractType = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? salary = null,
    Object? position = freezed,
    Object? department = freezed,
    Object? workingLocation = freezed,
    Object? contractDocument = freezed,
    Object? status = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salary: null == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as double,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      workingLocation: freezed == workingLocation
          ? _value.workingLocation
          : workingLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      contractDocument: freezed == contractDocument
          ? _value.contractDocument
          : contractDocument // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$EmployeeContractImplCopyWith<$Res>
    implements $EmployeeContractCopyWith<$Res> {
  factory _$$EmployeeContractImplCopyWith(_$EmployeeContractImpl value,
          $Res Function(_$EmployeeContractImpl) then) =
      __$$EmployeeContractImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String contractType,
      DateTime startDate,
      DateTime? endDate,
      double salary,
      String? position,
      String? department,
      String? workingLocation,
      String? contractDocument,
      String? status,
      String? notes,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$EmployeeContractImplCopyWithImpl<$Res>
    extends _$EmployeeContractCopyWithImpl<$Res, _$EmployeeContractImpl>
    implements _$$EmployeeContractImplCopyWith<$Res> {
  __$$EmployeeContractImplCopyWithImpl(_$EmployeeContractImpl _value,
      $Res Function(_$EmployeeContractImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? contractType = null,
    Object? startDate = null,
    Object? endDate = freezed,
    Object? salary = null,
    Object? position = freezed,
    Object? department = freezed,
    Object? workingLocation = freezed,
    Object? contractDocument = freezed,
    Object? status = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$EmployeeContractImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      salary: null == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as double,
      position: freezed == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String?,
      department: freezed == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String?,
      workingLocation: freezed == workingLocation
          ? _value.workingLocation
          : workingLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      contractDocument: freezed == contractDocument
          ? _value.contractDocument
          : contractDocument // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$EmployeeContractImpl implements _EmployeeContract {
  const _$EmployeeContractImpl(
      {required this.id,
      required this.employeeId,
      required this.contractType,
      required this.startDate,
      this.endDate,
      required this.salary,
      this.position,
      this.department,
      this.workingLocation,
      this.contractDocument,
      this.status,
      this.notes,
      required this.createdAt,
      required this.updatedAt});

  factory _$EmployeeContractImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmployeeContractImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final String contractType;
// 'probation', 'fixed_term', 'indefinite'
  @override
  final DateTime startDate;
  @override
  final DateTime? endDate;
  @override
  final double salary;
  @override
  final String? position;
  @override
  final String? department;
  @override
  final String? workingLocation;
  @override
  final String? contractDocument;
// URL or path to document
  @override
  final String? status;
// 'draft', 'active', 'ended', 'terminated'
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'EmployeeContract(id: $id, employeeId: $employeeId, contractType: $contractType, startDate: $startDate, endDate: $endDate, salary: $salary, position: $position, department: $department, workingLocation: $workingLocation, contractDocument: $contractDocument, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeContractImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.contractType, contractType) ||
                other.contractType == contractType) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.workingLocation, workingLocation) ||
                other.workingLocation == workingLocation) &&
            (identical(other.contractDocument, contractDocument) ||
                other.contractDocument == contractDocument) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
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
      employeeId,
      contractType,
      startDate,
      endDate,
      salary,
      position,
      department,
      workingLocation,
      contractDocument,
      status,
      notes,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeContractImplCopyWith<_$EmployeeContractImpl> get copyWith =>
      __$$EmployeeContractImplCopyWithImpl<_$EmployeeContractImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmployeeContractImplToJson(
      this,
    );
  }
}

abstract class _EmployeeContract implements EmployeeContract {
  const factory _EmployeeContract(
      {required final String id,
      required final String employeeId,
      required final String contractType,
      required final DateTime startDate,
      final DateTime? endDate,
      required final double salary,
      final String? position,
      final String? department,
      final String? workingLocation,
      final String? contractDocument,
      final String? status,
      final String? notes,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$EmployeeContractImpl;

  factory _EmployeeContract.fromJson(Map<String, dynamic> json) =
      _$EmployeeContractImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  String get contractType;
  @override // 'probation', 'fixed_term', 'indefinite'
  DateTime get startDate;
  @override
  DateTime? get endDate;
  @override
  double get salary;
  @override
  String? get position;
  @override
  String? get department;
  @override
  String? get workingLocation;
  @override
  String? get contractDocument;
  @override // URL or path to document
  String? get status;
  @override // 'draft', 'active', 'ended', 'terminated'
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$EmployeeContractImplCopyWith<_$EmployeeContractImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SalaryStructure _$SalaryStructureFromJson(Map<String, dynamic> json) {
  return _SalaryStructure.fromJson(json);
}

/// @nodoc
mixin _$SalaryStructure {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  double get basicSalary => throw _privateConstructorUsedError;
  double get allowance => throw _privateConstructorUsedError;
  double get bonus => throw _privateConstructorUsedError;
  double get deductions => throw _privateConstructorUsedError;
  double get bhxh =>
      throw _privateConstructorUsedError; // Social insurance rate (8%)
  double get taxAmount => throw _privateConstructorUsedError;
  double get netSalary => throw _privateConstructorUsedError;
  DateTime get effectiveDate => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SalaryStructureCopyWith<SalaryStructure> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SalaryStructureCopyWith<$Res> {
  factory $SalaryStructureCopyWith(
          SalaryStructure value, $Res Function(SalaryStructure) then) =
      _$SalaryStructureCopyWithImpl<$Res, SalaryStructure>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      double basicSalary,
      double allowance,
      double bonus,
      double deductions,
      double bhxh,
      double taxAmount,
      double netSalary,
      DateTime effectiveDate,
      DateTime updatedAt});
}

/// @nodoc
class _$SalaryStructureCopyWithImpl<$Res, $Val extends SalaryStructure>
    implements $SalaryStructureCopyWith<$Res> {
  _$SalaryStructureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? basicSalary = null,
    Object? allowance = null,
    Object? bonus = null,
    Object? deductions = null,
    Object? bhxh = null,
    Object? taxAmount = null,
    Object? netSalary = null,
    Object? effectiveDate = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      allowance: null == allowance
          ? _value.allowance
          : allowance // ignore: cast_nullable_to_non_nullable
              as double,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double,
      deductions: null == deductions
          ? _value.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as double,
      bhxh: null == bhxh
          ? _value.bhxh
          : bhxh // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      netSalary: null == netSalary
          ? _value.netSalary
          : netSalary // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveDate: null == effectiveDate
          ? _value.effectiveDate
          : effectiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SalaryStructureImplCopyWith<$Res>
    implements $SalaryStructureCopyWith<$Res> {
  factory _$$SalaryStructureImplCopyWith(_$SalaryStructureImpl value,
          $Res Function(_$SalaryStructureImpl) then) =
      __$$SalaryStructureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      double basicSalary,
      double allowance,
      double bonus,
      double deductions,
      double bhxh,
      double taxAmount,
      double netSalary,
      DateTime effectiveDate,
      DateTime updatedAt});
}

/// @nodoc
class __$$SalaryStructureImplCopyWithImpl<$Res>
    extends _$SalaryStructureCopyWithImpl<$Res, _$SalaryStructureImpl>
    implements _$$SalaryStructureImplCopyWith<$Res> {
  __$$SalaryStructureImplCopyWithImpl(
      _$SalaryStructureImpl _value, $Res Function(_$SalaryStructureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? basicSalary = null,
    Object? allowance = null,
    Object? bonus = null,
    Object? deductions = null,
    Object? bhxh = null,
    Object? taxAmount = null,
    Object? netSalary = null,
    Object? effectiveDate = null,
    Object? updatedAt = null,
  }) {
    return _then(_$SalaryStructureImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      basicSalary: null == basicSalary
          ? _value.basicSalary
          : basicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      allowance: null == allowance
          ? _value.allowance
          : allowance // ignore: cast_nullable_to_non_nullable
              as double,
      bonus: null == bonus
          ? _value.bonus
          : bonus // ignore: cast_nullable_to_non_nullable
              as double,
      deductions: null == deductions
          ? _value.deductions
          : deductions // ignore: cast_nullable_to_non_nullable
              as double,
      bhxh: null == bhxh
          ? _value.bhxh
          : bhxh // ignore: cast_nullable_to_non_nullable
              as double,
      taxAmount: null == taxAmount
          ? _value.taxAmount
          : taxAmount // ignore: cast_nullable_to_non_nullable
              as double,
      netSalary: null == netSalary
          ? _value.netSalary
          : netSalary // ignore: cast_nullable_to_non_nullable
              as double,
      effectiveDate: null == effectiveDate
          ? _value.effectiveDate
          : effectiveDate // ignore: cast_nullable_to_non_nullable
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
class _$SalaryStructureImpl implements _SalaryStructure {
  const _$SalaryStructureImpl(
      {required this.id,
      required this.employeeId,
      required this.basicSalary,
      required this.allowance,
      required this.bonus,
      required this.deductions,
      required this.bhxh,
      required this.taxAmount,
      required this.netSalary,
      required this.effectiveDate,
      required this.updatedAt});

  factory _$SalaryStructureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SalaryStructureImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final double basicSalary;
  @override
  final double allowance;
  @override
  final double bonus;
  @override
  final double deductions;
  @override
  final double bhxh;
// Social insurance rate (8%)
  @override
  final double taxAmount;
  @override
  final double netSalary;
  @override
  final DateTime effectiveDate;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SalaryStructure(id: $id, employeeId: $employeeId, basicSalary: $basicSalary, allowance: $allowance, bonus: $bonus, deductions: $deductions, bhxh: $bhxh, taxAmount: $taxAmount, netSalary: $netSalary, effectiveDate: $effectiveDate, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SalaryStructureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.basicSalary, basicSalary) ||
                other.basicSalary == basicSalary) &&
            (identical(other.allowance, allowance) ||
                other.allowance == allowance) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.deductions, deductions) ||
                other.deductions == deductions) &&
            (identical(other.bhxh, bhxh) || other.bhxh == bhxh) &&
            (identical(other.taxAmount, taxAmount) ||
                other.taxAmount == taxAmount) &&
            (identical(other.netSalary, netSalary) ||
                other.netSalary == netSalary) &&
            (identical(other.effectiveDate, effectiveDate) ||
                other.effectiveDate == effectiveDate) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      employeeId,
      basicSalary,
      allowance,
      bonus,
      deductions,
      bhxh,
      taxAmount,
      netSalary,
      effectiveDate,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SalaryStructureImplCopyWith<_$SalaryStructureImpl> get copyWith =>
      __$$SalaryStructureImplCopyWithImpl<_$SalaryStructureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SalaryStructureImplToJson(
      this,
    );
  }
}

abstract class _SalaryStructure implements SalaryStructure {
  const factory _SalaryStructure(
      {required final String id,
      required final String employeeId,
      required final double basicSalary,
      required final double allowance,
      required final double bonus,
      required final double deductions,
      required final double bhxh,
      required final double taxAmount,
      required final double netSalary,
      required final DateTime effectiveDate,
      required final DateTime updatedAt}) = _$SalaryStructureImpl;

  factory _SalaryStructure.fromJson(Map<String, dynamic> json) =
      _$SalaryStructureImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  double get basicSalary;
  @override
  double get allowance;
  @override
  double get bonus;
  @override
  double get deductions;
  @override
  double get bhxh;
  @override // Social insurance rate (8%)
  double get taxAmount;
  @override
  double get netSalary;
  @override
  DateTime get effectiveDate;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$SalaryStructureImplCopyWith<_$SalaryStructureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
