import '../../../../core/services/api_service.dart';
import '../models/attendance_model.dart';

class AttendanceRepository {
  final ApiService _apiService;

  AttendanceRepository(this._apiService);

  Future<List<AttendanceRecord>> getAttendanceByEmployeeId(
    String employeeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final query = {
        'employee_id': employeeId,
        if (startDate != null) 'start_date': startDate.toIso8601String(),
        if (endDate != null) 'end_date': endDate.toIso8601String(),
      };

      final data = await _apiService.get('/api/attendance', queryParameters: query);

      if (data is List) {
        return data.map((e) => AttendanceRecord.fromJson(e as Map<String, dynamic>)).toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceRecord> createAttendanceRecord(
    AttendanceRecord record,
  ) async {
    try {
      final payload = {
        'employee_id': record.employeeId,
        'check_in_time': record.checkInTime.toIso8601String(),
        'check_out_time': record.checkOutTime?.toIso8601String(),
        'status': record.status,
        'notes': record.notes,
        'qr_code_data': record.qrCodeData,
        'location': record.location,
      };

      final data = await _apiService.post('/api/attendance', data: payload);

      return AttendanceRecord.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceRecord> updateAttendanceRecord(
    AttendanceRecord record,
  ) async {
    try {
      final payload = {
        'check_out_time': record.checkOutTime?.toIso8601String(),
        'status': record.status,
        'notes': record.notes,
      };

      final data = await _apiService.put('/api/attendance/${record.id}', data: payload);

      return AttendanceRecord.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<AttendanceSummary> getAttendanceSummary(
    String employeeId,
    int month,
    int year,
  ) async {
    try {
      final data = await _apiService.get('/api/attendance/summary', queryParameters: {
        'employee_id': employeeId,
        'month': month,
        'year': year,
      });

      return AttendanceSummary.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
