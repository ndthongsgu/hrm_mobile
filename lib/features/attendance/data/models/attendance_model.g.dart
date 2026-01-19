// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttendanceRecordImpl _$$AttendanceRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceRecordImpl(
      id: json['id'] as String,
      employeeId: json['employeeId'] as String,
      checkInTime: DateTime.parse(json['checkInTime'] as String),
      checkOutTime: json['checkOutTime'] == null
          ? null
          : DateTime.parse(json['checkOutTime'] as String),
      status: json['status'] as String,
      notes: json['notes'] as String?,
      qrCodeData: json['qrCodeData'] as String?,
      location: json['location'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$AttendanceRecordImplToJson(
        _$AttendanceRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'checkInTime': instance.checkInTime.toIso8601String(),
      'checkOutTime': instance.checkOutTime?.toIso8601String(),
      'status': instance.status,
      'notes': instance.notes,
      'qrCodeData': instance.qrCodeData,
      'location': instance.location,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

_$AttendanceSummaryImpl _$$AttendanceSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$AttendanceSummaryImpl(
      employeeId: json['employeeId'] as String,
      totalDays: (json['totalDays'] as num).toInt(),
      presentDays: (json['presentDays'] as num).toInt(),
      absentDays: (json['absentDays'] as num).toInt(),
      lateDays: (json['lateDays'] as num).toInt(),
      halfDays: (json['halfDays'] as num).toInt(),
      attendanceRate: (json['attendanceRate'] as num).toDouble(),
      monthYear: DateTime.parse(json['monthYear'] as String),
    );

Map<String, dynamic> _$$AttendanceSummaryImplToJson(
        _$AttendanceSummaryImpl instance) =>
    <String, dynamic>{
      'employeeId': instance.employeeId,
      'totalDays': instance.totalDays,
      'presentDays': instance.presentDays,
      'absentDays': instance.absentDays,
      'lateDays': instance.lateDays,
      'halfDays': instance.halfDays,
      'attendanceRate': instance.attendanceRate,
      'monthYear': instance.monthYear.toIso8601String(),
    };
