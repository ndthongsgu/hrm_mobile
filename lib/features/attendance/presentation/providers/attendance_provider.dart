import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../../data/repositories/attendance_repository.dart';
import '../../data/models/attendance_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final attendanceRepositoryProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AttendanceRepository(apiService);
});

// Get attendance records for employee
final employeeAttendanceProvider = FutureProvider.family<
    List<AttendanceRecord>,
    String>((ref, employeeId) async {
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.getAttendanceByEmployeeId(employeeId);
});

// Get attendance summary
final attendanceSummaryProvider = FutureProvider.family<
    AttendanceSummary,
    (String employeeId, int month, int year)>((ref, params) async {
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.getAttendanceSummary(params.$1, params.$2, params.$3);
});

// Create attendance record
final createAttendanceProvider =
    FutureProvider.family<AttendanceRecord, AttendanceRecord>((ref, record) async {
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.createAttendanceRecord(record);
});

// Update attendance record
final updateAttendanceProvider =
    FutureProvider.family<AttendanceRecord, AttendanceRecord>((ref, record) async {
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.updateAttendanceRecord(record);
});
