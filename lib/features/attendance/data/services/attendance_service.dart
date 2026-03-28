import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hrm_mobile/config/env.dart';

class AttendanceService {

  static const String checkInEndpoint = '/api/daily-attendances/check-in';
  final _storage = GetStorage();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiBaseUrl,
      connectTimeout: Environment.apiTimeoutDuration,
      receiveTimeout: Environment.apiTimeoutDuration,
    ),
  );

  AttendanceService() {
    // Add interceptor to include auth token in all requests
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.read('auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  /// Get employee information including office location and shift details
  Future<Map<String, dynamic>> getEmployeeData(String employeeId) async {
    try {
      final response = await _dio.get('/api/employees/$employeeId');

      if (response.statusCode == 200 && response.data['data'] != null) {
        return response.data['data'];
      } else {
        throw Exception('Failed to fetch employee data');
      }
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      throw Exception('Lỗi không xác định: $e');
    }
  }

  /// Get today's attendance record for an employee
  Future<Map<String, dynamic>?> getTodayAttendance(String employeeId) async {
    try {
      final response = await _dio.get('/api/daily-attendances/today/$employeeId');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data != null) {
          return data;
        }
        return null; // No attendance record today
      } else {
        throw Exception('Failed to fetch attendance record');
      }
    } on DioException catch (e) {
      // Return null if 404 (no record found today)
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      throw Exception('Lỗi không xác định: $e');
    }
  }

  /// Perform check-in with face recognition and location verification
  /// 
  /// Returns a Map with the API response
  Future<Map<String, dynamic>> checkIn({
    required String employeeId,
    required File imageFile,
    required double latitude,
    required double longitude,
    String? deviceId,
    String? notes,
  }) async {
    try {
      final FormData formData = FormData.fromMap({
        'employeeId': employeeId,
        'latitude': latitude,
        'longitude': longitude,
        'file': await MultipartFile.fromFile(imageFile.path),
        if (deviceId != null) 'deviceId': deviceId,
        if (notes != null) 'notes': notes,
      });

      final response = await _dio.post(
        checkInEndpoint,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract success from the actual API response (inside 'data' field)
        final apiResponse = response.data['data'] as Map<String, dynamic>? ?? {};
        return {
          'success': apiResponse['success'] ?? false,  // Get actual success field from API response
          'message': apiResponse['message'] ?? response.data['message'] ?? 'Error',
          'data': apiResponse,  // Return full API response
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': _getErrorMessage(e),
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi không xác định: $e',
      };
    }
  }

  /// Get today's shift information for an employee
  Future<Map<String, dynamic>> getTodaysShift(String employeeId) async {
    try {
      final response = await _dio.get('/api/daily-attendances/shift/today/$employeeId');

      if (response.statusCode == 200 && response.data['data'] != null) {
        final data = response.data['data'] as Map<String, dynamic>;
        // Return values directly from backend without providing defaults
        return {
          'name': data['name'],
          'startTime': data['startTime'],
          'endTime': data['endTime'],
          'breakStart': data['breakStart'],
          'breakEnd': data['breakEnd'],
          'checkInTime': data['checkInTime'],
          'checkOutTime': data['checkOutTime'],
          'status': data['status'],
        };
      } else {
        // Return all null when no data
        return {
          'name': null,
          'startTime': null,
          'endTime': null,
          'breakStart': null,
          'breakEnd': null,
          'checkInTime': null,
          'checkOutTime': null,
          'status': null,
        };
      }
    } on DioException catch (e) {
      // Return all null on API error
      return {
        'name': null,
        'startTime': null,
        'endTime': null,
        'breakStart': null,
        'breakEnd': null,
        'checkInTime': null,
        'checkOutTime': null,
        'status': null,
      };
    } catch (e) {
      // Return all null on unexpected error
      return {
        'name': null,
        'startTime': null,
        'endTime': null,
        'breakStart': null,
        'breakEnd': null,
        'checkInTime': null,
        'checkOutTime': null,
        'status': null,
      };
    }
  }

  /// Get monthly attendance data for an employee
  Future<Map<String, dynamic>> getMonthlyAttendance(
    String employeeId,
    int year,
    int month,
  ) async {
    try {
      final response = await _dio.get(
        '/api/daily-attendances/monthly/$employeeId',
        queryParameters: {
          'year': year,
          'month': month,
        },
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        return response.data['data'] as Map<String, dynamic>;
      } else {
        throw Exception('Failed to fetch monthly attendance data');
      }
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      throw Exception('Lỗi không xác định: $e');
    }
  }

  /// Perform check-out - records end time for today's attendance
  Future<Map<String, dynamic>> checkOut({
    required String employeeId,
    required double latitude,
    required double longitude,
    String? deviceId,
    String? notes,
  }) async {
    try {
      final response = await _dio.post(
        '/api/daily-attendances/check-out',
        queryParameters: {
          'employeeId': employeeId,
          'latitude': latitude,
          'longitude': longitude,
          if (deviceId != null) 'deviceId': deviceId,
          if (notes != null) 'notes': notes,
        },
      );

      if (response.statusCode == 200) {
        // Extract success from the actual API response (inside 'data' field)
        final apiResponse = response.data['data'] as Map<String, dynamic>? ?? {};
        return {
          'success': apiResponse['success'] ?? false,  // Get actual success field from API response
          'message': apiResponse['message'] ?? response.data['message'] ?? 'Kết thúc chấm công',
          'data': apiResponse,  // Return full API response
        };
      } else {
        return {
          'success': false,
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'message': _getErrorMessage(e),
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Lỗi không xác định: $e',
      };
    }
  }

  /// Get error message from DioException
  String _getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Hết thời gian kết nối';
      case DioExceptionType.sendTimeout:
        return 'Hết thời gian gửi dữ liệu';
      case DioExceptionType.receiveTimeout:
        return 'Hết thời gian nhận dữ liệu';
      case DioExceptionType.badResponse:
        if (e.response?.data is Map) {
          return e.response?.data['message'] ?? 'Lỗi từ server';
        }
        return 'Lỗi: ${e.response?.statusCode}';
      case DioExceptionType.cancel:
        return 'Yêu cầu đã bị hủy';
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return 'Không thể kết nối đến server';
        }
        return 'Lỗi kết nối: ${e.error}';
      default:
        return 'Lỗi không xác định';
    }
  }
}
