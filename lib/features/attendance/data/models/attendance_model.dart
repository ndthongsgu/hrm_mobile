import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
class AttendanceRecord with _$AttendanceRecord {
  const factory AttendanceRecord({
    required String id,
    required String employeeId,
    required DateTime checkInTime,
    DateTime? checkOutTime,
    required String status, // 'present', 'late', 'absent', 'half_day'
    String? notes,
    String? qrCodeData,
    String? location,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _AttendanceRecord;

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordFromJson(json);
}

@freezed
class AttendanceSummary with _$AttendanceSummary {
  const factory AttendanceSummary({
    required String employeeId,
    required int totalDays,
    required int presentDays,
    required int absentDays,
    required int lateDays,
    required int halfDays,
    required double attendanceRate,
    required DateTime monthYear,
  }) = _AttendanceSummary;

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) =>
      _$AttendanceSummaryFromJson(json);
}
