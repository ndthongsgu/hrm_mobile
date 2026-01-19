// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payroll_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Payroll _$PayrollFromJson(Map<String, dynamic> json) {
  return _Payroll.fromJson(json);
}

/// @nodoc
mixin _$Payroll {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  String get employeeName => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  double get basicSalary => throw _privateConstructorUsedError;
  double get allowance => throw _privateConstructorUsedError;
  double get bonus => throw _privateConstructorUsedError;
  double get bhxh =>
      throw _privateConstructorUsedError; // Social insurance (8% of basic salary)
  double get personalIncomeTax => throw _privateConstructorUsedError;
  double get otherDeductions => throw _privateConstructorUsedError;
  double get totalDeductions => throw _privateConstructorUsedError;
  double get netSalary => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'draft', 'pending_approval', 'approved', 'paid'
  String? get notes => throw _privateConstructorUsedError;
  String? get pdfUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get paidDate => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollCopyWith<Payroll> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollCopyWith<$Res> {
  factory $PayrollCopyWith(Payroll value, $Res Function(Payroll) then) =
      _$PayrollCopyWithImpl<$Res, Payroll>;
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String employeeName,
      int month,
      int year,
      double basicSalary,
      double allowance,
      double bonus,
      double bhxh,
      double personalIncomeTax,
      double otherDeductions,
      double totalDeductions,
      double netSalary,
      String status,
      String? notes,
      String? pdfUrl,
      DateTime createdAt,
      DateTime? paidDate,
      DateTime updatedAt});
}

/// @nodoc
class _$PayrollCopyWithImpl<$Res, $Val extends Payroll>
    implements $PayrollCopyWith<$Res> {
  _$PayrollCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? month = null,
    Object? year = null,
    Object? basicSalary = null,
    Object? allowance = null,
    Object? bonus = null,
    Object? bhxh = null,
    Object? personalIncomeTax = null,
    Object? otherDeductions = null,
    Object? totalDeductions = null,
    Object? netSalary = null,
    Object? status = null,
    Object? notes = freezed,
    Object? pdfUrl = freezed,
    Object? createdAt = null,
    Object? paidDate = freezed,
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
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
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
      bhxh: null == bhxh
          ? _value.bhxh
          : bhxh // ignore: cast_nullable_to_non_nullable
              as double,
      personalIncomeTax: null == personalIncomeTax
          ? _value.personalIncomeTax
          : personalIncomeTax // ignore: cast_nullable_to_non_nullable
              as double,
      otherDeductions: null == otherDeductions
          ? _value.otherDeductions
          : otherDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      netSalary: null == netSalary
          ? _value.netSalary
          : netSalary // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidDate: freezed == paidDate
          ? _value.paidDate
          : paidDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollImplCopyWith<$Res> implements $PayrollCopyWith<$Res> {
  factory _$$PayrollImplCopyWith(
          _$PayrollImpl value, $Res Function(_$PayrollImpl) then) =
      __$$PayrollImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String employeeId,
      String employeeName,
      int month,
      int year,
      double basicSalary,
      double allowance,
      double bonus,
      double bhxh,
      double personalIncomeTax,
      double otherDeductions,
      double totalDeductions,
      double netSalary,
      String status,
      String? notes,
      String? pdfUrl,
      DateTime createdAt,
      DateTime? paidDate,
      DateTime updatedAt});
}

/// @nodoc
class __$$PayrollImplCopyWithImpl<$Res>
    extends _$PayrollCopyWithImpl<$Res, _$PayrollImpl>
    implements _$$PayrollImplCopyWith<$Res> {
  __$$PayrollImplCopyWithImpl(
      _$PayrollImpl _value, $Res Function(_$PayrollImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? employeeName = null,
    Object? month = null,
    Object? year = null,
    Object? basicSalary = null,
    Object? allowance = null,
    Object? bonus = null,
    Object? bhxh = null,
    Object? personalIncomeTax = null,
    Object? otherDeductions = null,
    Object? totalDeductions = null,
    Object? netSalary = null,
    Object? status = null,
    Object? notes = freezed,
    Object? pdfUrl = freezed,
    Object? createdAt = null,
    Object? paidDate = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_$PayrollImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      employeeId: null == employeeId
          ? _value.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String,
      employeeName: null == employeeName
          ? _value.employeeName
          : employeeName // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
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
      bhxh: null == bhxh
          ? _value.bhxh
          : bhxh // ignore: cast_nullable_to_non_nullable
              as double,
      personalIncomeTax: null == personalIncomeTax
          ? _value.personalIncomeTax
          : personalIncomeTax // ignore: cast_nullable_to_non_nullable
              as double,
      otherDeductions: null == otherDeductions
          ? _value.otherDeductions
          : otherDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      netSalary: null == netSalary
          ? _value.netSalary
          : netSalary // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      pdfUrl: freezed == pdfUrl
          ? _value.pdfUrl
          : pdfUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidDate: freezed == paidDate
          ? _value.paidDate
          : paidDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollImpl implements _Payroll {
  const _$PayrollImpl(
      {required this.id,
      required this.employeeId,
      required this.employeeName,
      required this.month,
      required this.year,
      required this.basicSalary,
      required this.allowance,
      required this.bonus,
      required this.bhxh,
      required this.personalIncomeTax,
      required this.otherDeductions,
      required this.totalDeductions,
      required this.netSalary,
      required this.status,
      this.notes,
      this.pdfUrl,
      required this.createdAt,
      this.paidDate,
      required this.updatedAt});

  factory _$PayrollImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final String employeeName;
  @override
  final int month;
  @override
  final int year;
  @override
  final double basicSalary;
  @override
  final double allowance;
  @override
  final double bonus;
  @override
  final double bhxh;
// Social insurance (8% of basic salary)
  @override
  final double personalIncomeTax;
  @override
  final double otherDeductions;
  @override
  final double totalDeductions;
  @override
  final double netSalary;
  @override
  final String status;
// 'draft', 'pending_approval', 'approved', 'paid'
  @override
  final String? notes;
  @override
  final String? pdfUrl;
  @override
  final DateTime createdAt;
  @override
  final DateTime? paidDate;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Payroll(id: $id, employeeId: $employeeId, employeeName: $employeeName, month: $month, year: $year, basicSalary: $basicSalary, allowance: $allowance, bonus: $bonus, bhxh: $bhxh, personalIncomeTax: $personalIncomeTax, otherDeductions: $otherDeductions, totalDeductions: $totalDeductions, netSalary: $netSalary, status: $status, notes: $notes, pdfUrl: $pdfUrl, createdAt: $createdAt, paidDate: $paidDate, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.employeeName, employeeName) ||
                other.employeeName == employeeName) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.basicSalary, basicSalary) ||
                other.basicSalary == basicSalary) &&
            (identical(other.allowance, allowance) ||
                other.allowance == allowance) &&
            (identical(other.bonus, bonus) || other.bonus == bonus) &&
            (identical(other.bhxh, bhxh) || other.bhxh == bhxh) &&
            (identical(other.personalIncomeTax, personalIncomeTax) ||
                other.personalIncomeTax == personalIncomeTax) &&
            (identical(other.otherDeductions, otherDeductions) ||
                other.otherDeductions == otherDeductions) &&
            (identical(other.totalDeductions, totalDeductions) ||
                other.totalDeductions == totalDeductions) &&
            (identical(other.netSalary, netSalary) ||
                other.netSalary == netSalary) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.pdfUrl, pdfUrl) || other.pdfUrl == pdfUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paidDate, paidDate) ||
                other.paidDate == paidDate) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        employeeId,
        employeeName,
        month,
        year,
        basicSalary,
        allowance,
        bonus,
        bhxh,
        personalIncomeTax,
        otherDeductions,
        totalDeductions,
        netSalary,
        status,
        notes,
        pdfUrl,
        createdAt,
        paidDate,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollImplCopyWith<_$PayrollImpl> get copyWith =>
      __$$PayrollImplCopyWithImpl<_$PayrollImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollImplToJson(
      this,
    );
  }
}

abstract class _Payroll implements Payroll {
  const factory _Payroll(
      {required final String id,
      required final String employeeId,
      required final String employeeName,
      required final int month,
      required final int year,
      required final double basicSalary,
      required final double allowance,
      required final double bonus,
      required final double bhxh,
      required final double personalIncomeTax,
      required final double otherDeductions,
      required final double totalDeductions,
      required final double netSalary,
      required final String status,
      final String? notes,
      final String? pdfUrl,
      required final DateTime createdAt,
      final DateTime? paidDate,
      required final DateTime updatedAt}) = _$PayrollImpl;

  factory _Payroll.fromJson(Map<String, dynamic> json) = _$PayrollImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  String get employeeName;
  @override
  int get month;
  @override
  int get year;
  @override
  double get basicSalary;
  @override
  double get allowance;
  @override
  double get bonus;
  @override
  double get bhxh;
  @override // Social insurance (8% of basic salary)
  double get personalIncomeTax;
  @override
  double get otherDeductions;
  @override
  double get totalDeductions;
  @override
  double get netSalary;
  @override
  String get status;
  @override // 'draft', 'pending_approval', 'approved', 'paid'
  String? get notes;
  @override
  String? get pdfUrl;
  @override
  DateTime get createdAt;
  @override
  DateTime? get paidDate;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$PayrollImplCopyWith<_$PayrollImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayrollSummary _$PayrollSummaryFromJson(Map<String, dynamic> json) {
  return _PayrollSummary.fromJson(json);
}

/// @nodoc
mixin _$PayrollSummary {
  int get month => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get totalEmployees => throw _privateConstructorUsedError;
  int get processedPayroll => throw _privateConstructorUsedError;
  double get totalBasicSalary => throw _privateConstructorUsedError;
  double get totalAllowances => throw _privateConstructorUsedError;
  double get totalDeductions => throw _privateConstructorUsedError;
  double get totalNetSalary => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayrollSummaryCopyWith<PayrollSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayrollSummaryCopyWith<$Res> {
  factory $PayrollSummaryCopyWith(
          PayrollSummary value, $Res Function(PayrollSummary) then) =
      _$PayrollSummaryCopyWithImpl<$Res, PayrollSummary>;
  @useResult
  $Res call(
      {int month,
      int year,
      int totalEmployees,
      int processedPayroll,
      double totalBasicSalary,
      double totalAllowances,
      double totalDeductions,
      double totalNetSalary,
      String status,
      DateTime createdAt});
}

/// @nodoc
class _$PayrollSummaryCopyWithImpl<$Res, $Val extends PayrollSummary>
    implements $PayrollSummaryCopyWith<$Res> {
  _$PayrollSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? totalEmployees = null,
    Object? processedPayroll = null,
    Object? totalBasicSalary = null,
    Object? totalAllowances = null,
    Object? totalDeductions = null,
    Object? totalNetSalary = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      processedPayroll: null == processedPayroll
          ? _value.processedPayroll
          : processedPayroll // ignore: cast_nullable_to_non_nullable
              as int,
      totalBasicSalary: null == totalBasicSalary
          ? _value.totalBasicSalary
          : totalBasicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      totalAllowances: null == totalAllowances
          ? _value.totalAllowances
          : totalAllowances // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      totalNetSalary: null == totalNetSalary
          ? _value.totalNetSalary
          : totalNetSalary // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayrollSummaryImplCopyWith<$Res>
    implements $PayrollSummaryCopyWith<$Res> {
  factory _$$PayrollSummaryImplCopyWith(_$PayrollSummaryImpl value,
          $Res Function(_$PayrollSummaryImpl) then) =
      __$$PayrollSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int month,
      int year,
      int totalEmployees,
      int processedPayroll,
      double totalBasicSalary,
      double totalAllowances,
      double totalDeductions,
      double totalNetSalary,
      String status,
      DateTime createdAt});
}

/// @nodoc
class __$$PayrollSummaryImplCopyWithImpl<$Res>
    extends _$PayrollSummaryCopyWithImpl<$Res, _$PayrollSummaryImpl>
    implements _$$PayrollSummaryImplCopyWith<$Res> {
  __$$PayrollSummaryImplCopyWithImpl(
      _$PayrollSummaryImpl _value, $Res Function(_$PayrollSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? year = null,
    Object? totalEmployees = null,
    Object? processedPayroll = null,
    Object? totalBasicSalary = null,
    Object? totalAllowances = null,
    Object? totalDeductions = null,
    Object? totalNetSalary = null,
    Object? status = null,
    Object? createdAt = null,
  }) {
    return _then(_$PayrollSummaryImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      year: null == year
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      totalEmployees: null == totalEmployees
          ? _value.totalEmployees
          : totalEmployees // ignore: cast_nullable_to_non_nullable
              as int,
      processedPayroll: null == processedPayroll
          ? _value.processedPayroll
          : processedPayroll // ignore: cast_nullable_to_non_nullable
              as int,
      totalBasicSalary: null == totalBasicSalary
          ? _value.totalBasicSalary
          : totalBasicSalary // ignore: cast_nullable_to_non_nullable
              as double,
      totalAllowances: null == totalAllowances
          ? _value.totalAllowances
          : totalAllowances // ignore: cast_nullable_to_non_nullable
              as double,
      totalDeductions: null == totalDeductions
          ? _value.totalDeductions
          : totalDeductions // ignore: cast_nullable_to_non_nullable
              as double,
      totalNetSalary: null == totalNetSalary
          ? _value.totalNetSalary
          : totalNetSalary // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayrollSummaryImpl implements _PayrollSummary {
  const _$PayrollSummaryImpl(
      {required this.month,
      required this.year,
      required this.totalEmployees,
      required this.processedPayroll,
      required this.totalBasicSalary,
      required this.totalAllowances,
      required this.totalDeductions,
      required this.totalNetSalary,
      required this.status,
      required this.createdAt});

  factory _$PayrollSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayrollSummaryImplFromJson(json);

  @override
  final int month;
  @override
  final int year;
  @override
  final int totalEmployees;
  @override
  final int processedPayroll;
  @override
  final double totalBasicSalary;
  @override
  final double totalAllowances;
  @override
  final double totalDeductions;
  @override
  final double totalNetSalary;
  @override
  final String status;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'PayrollSummary(month: $month, year: $year, totalEmployees: $totalEmployees, processedPayroll: $processedPayroll, totalBasicSalary: $totalBasicSalary, totalAllowances: $totalAllowances, totalDeductions: $totalDeductions, totalNetSalary: $totalNetSalary, status: $status, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayrollSummaryImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.totalEmployees, totalEmployees) ||
                other.totalEmployees == totalEmployees) &&
            (identical(other.processedPayroll, processedPayroll) ||
                other.processedPayroll == processedPayroll) &&
            (identical(other.totalBasicSalary, totalBasicSalary) ||
                other.totalBasicSalary == totalBasicSalary) &&
            (identical(other.totalAllowances, totalAllowances) ||
                other.totalAllowances == totalAllowances) &&
            (identical(other.totalDeductions, totalDeductions) ||
                other.totalDeductions == totalDeductions) &&
            (identical(other.totalNetSalary, totalNetSalary) ||
                other.totalNetSalary == totalNetSalary) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      month,
      year,
      totalEmployees,
      processedPayroll,
      totalBasicSalary,
      totalAllowances,
      totalDeductions,
      totalNetSalary,
      status,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PayrollSummaryImplCopyWith<_$PayrollSummaryImpl> get copyWith =>
      __$$PayrollSummaryImplCopyWithImpl<_$PayrollSummaryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayrollSummaryImplToJson(
      this,
    );
  }
}

abstract class _PayrollSummary implements PayrollSummary {
  const factory _PayrollSummary(
      {required final int month,
      required final int year,
      required final int totalEmployees,
      required final int processedPayroll,
      required final double totalBasicSalary,
      required final double totalAllowances,
      required final double totalDeductions,
      required final double totalNetSalary,
      required final String status,
      required final DateTime createdAt}) = _$PayrollSummaryImpl;

  factory _PayrollSummary.fromJson(Map<String, dynamic> json) =
      _$PayrollSummaryImpl.fromJson;

  @override
  int get month;
  @override
  int get year;
  @override
  int get totalEmployees;
  @override
  int get processedPayroll;
  @override
  double get totalBasicSalary;
  @override
  double get totalAllowances;
  @override
  double get totalDeductions;
  @override
  double get totalNetSalary;
  @override
  String get status;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$PayrollSummaryImplCopyWith<_$PayrollSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
