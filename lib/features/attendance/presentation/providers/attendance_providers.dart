import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrm_mobile/features/attendance/data/services/attendance_service.dart';
import 'package:hrm_mobile/features/auth/auth_provider.dart';

// Placeholder provider - gọi API trực tiếp từ screen thay vì dùng provider
final attendanceServiceProvider = Provider((ref) => AttendanceService());
