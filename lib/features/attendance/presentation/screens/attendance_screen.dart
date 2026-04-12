import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';
import 'package:hrm_mobile/config/theme.dart';
import 'package:hrm_mobile/config/env.dart';
import 'package:hrm_mobile/features/attendance/data/services/attendance_service.dart';
import 'package:hrm_mobile/features/auth/auth_provider.dart';
import 'package:hrm_mobile/features/auth/models/auth_models.dart';
import 'package:hrm_mobile/utils/distance_utils.dart';
import 'package:hrm_mobile/utils/location_utils.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // Location checking
  double? _currentLatitude;
  double? _currentLongitude;
  bool _isCheckingLocation = false;
  double? _calculatedDistance; // Distance to office in meters

  // Location and IP info
  String? _currentLocationAddress;
  String? _deviceIP;

  // State variables for shift/employee data
  Map<String, dynamic>? _shiftData;
  Map<String, dynamic>? _employeeData;
  bool _isLoadingShiftData = true;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
    _loadShiftData(); // Load shift data on screen open
  }

  /// Load shift + employee data directly from API (no caching)
  Future<void> _loadShiftData() async {
    setState(() => _isLoadingShiftData = true);

    try {
      UserProfile? user = ref.read(userProvider);

      if (user == null) {
        // Try to load user profile if not available
        await ref.read(userProvider.notifier).loadUserProfile();
        user = ref.read(userProvider);
      }

      if (user == null || user.employee?.id == null) {
        throw Exception('Không thể lấy thông tin nhân viên');
      }

      final employeeId = user.employee!.id;
      final service = AttendanceService();

      // Call API directly - no cache
      final employeeData = await service.getEmployeeData(employeeId);
      final shiftData = await service.getTodaysShift(employeeId);

      setState(() {
        _employeeData = employeeData;
        _shiftData = shiftData;
        _isLoadingShiftData = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi tải dữ liệu: $e';
        _isLoadingShiftData = false;
      });
    }
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        // Use front camera for selfie
        final frontCamera = _cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => _cameras[0],
        );

        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.medium,
          enableAudio: false,
        );

        await _cameraController?.initialize();
        if (mounted) {
          setState(() {});
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Lỗi khởi tạo camera: $e';
        });
      }
    }
  }

  Future<void> _performCheckIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // Step 1: Check permission
      if (_cameraController == null ||
          !_cameraController!.value.isInitialized) {
        throw Exception('Camera chưa khởi tạo, vui lòng quay lại và thử lại');
      }

      // Step 2: Automatically capture photo
      final XFile capturedImage = await _cameraController!.takePicture();
      final imageFile = File(capturedImage.path);

      // Step 3: Get location automatically
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Cần cấp quyền vị trí để chấm công');
      }

      final position =
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            timeLimit: Environment.gpsLocationTimeout,
          ).timeout(
            Environment.gpsFallbackTimeout,
            onTimeout: () async {
              // Fallback to high accuracy if timeout
              return await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                timeLimit: Environment.gpsFallbackDurationLimit,
              );
            },
          );

      // Step 4: Call API with auto-captured photo and location
      final checkInResponse = await _callCheckInAPI(
        imageFile: imageFile,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (checkInResponse['success']) {
        setState(() {
          _successMessage =
              checkInResponse['message'] ?? 'Chấm công thành công';
        });
        Get.snackbar(
          'Thành công',
          checkInResponse['message'] ?? 'Chấm công thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload data immediately
        await Future.delayed(const Duration(milliseconds: 500));
        await _loadShiftData();
      } else {
        setState(() {
          _errorMessage = checkInResponse['message'] ?? 'Chấm công thất bại';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _performCheckOut() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      // Get location for check-out
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Cần cấp quyền vị trí để chấm công');
      }

      final position =
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            timeLimit: Environment.gpsLocationTimeout,
          ).timeout(
            Environment.gpsFallbackTimeout,
            onTimeout: () async {
              return await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                timeLimit: Environment.gpsFallbackDurationLimit,
              );
            },
          );

      // Call check-out API
      final checkOutResponse = await _callCheckOutAPI(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      if (checkOutResponse['success']) {
        setState(() {
          _successMessage =
              checkOutResponse['message'] ?? 'Kết thúc chấm công thành công';
        });
        Get.snackbar(
          'Thành công',
          checkOutResponse['message'] ?? 'Kết thúc chấm công thành công',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Reload data immediately
        await Future.delayed(const Duration(milliseconds: 500));
        await _loadShiftData();
      } else {
        setState(() {
          _errorMessage =
              checkOutResponse['message'] ?? 'Kết thúc chấm công thất bại';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _checkCurrentLocation() async {
    setState(() {
      _isCheckingLocation = true;
      _currentLatitude = null;
      _currentLongitude = null;
      _currentLocationAddress = null;
      _deviceIP = null;
    });

    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Cần cấp quyền truy cập vị trí');
      }

      // Get current position with timeout
      final position =
          await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            timeLimit: Environment.gpsLocationTimeout,
          ).timeout(
            Environment.gpsFallbackTimeout,
            onTimeout: () async {
              // Fallback to high accuracy if timeout
              return await Geolocator.getCurrentPosition(
                desiredAccuracy: LocationAccuracy.high,
                timeLimit: Environment.gpsFallbackDurationLimit,
              );
            },
          );

      // Get address from coordinates
      final address = LocationUtils.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Get device IP address (non-blocking)
      final ip = await LocationUtils.getPublicIP();

      setState(() {
        _currentLatitude = position.latitude;
        _currentLongitude = position.longitude;
        _currentLocationAddress = address;
        _deviceIP = ip;
      });

      // Calculate distance to office if employee data is available
      if (_employeeData != null) {
        try {
          final officeLocation =
              _employeeData!['officeLocation'] as Map<String, dynamic>?;
          if (officeLocation != null) {
            final officeLatitude = officeLocation['latitude'] as double?;
            final officeLongitude = officeLocation['longitude'] as double?;

            if (officeLatitude != null && officeLongitude != null) {
              setState(() {
                _calculatedDistance = DistanceUtils.calculateDistance(
                  lat1: position.latitude,
                  lon1: position.longitude,
                  lat2: officeLatitude,
                  lon2: officeLongitude,
                );
              });
            }
          }
        } catch (e) {
          // Silently ignore error, distance will show N/A
        }
      }

      Get.snackbar(
        'Thành công',
        'Cập nhật vị trí thành công',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Lỗi cập nhật vị trí: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isCheckingLocation = false;
      });
    }
  }

  Future<Map<String, dynamic>> _callCheckInAPI({
    required File imageFile,
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Get employee ID from auth context via Riverpod
      final user = ref.read(userProvider);

      if (user == null || user.employee?.id == null) {
        return {
          'success': false,
          'message':
              'Không thể lấy thông tin nhân viên. Vui lòng đăng nhập lại.',
        };
      }

      final String employeeId = user.employee!.id;

      final response = await AttendanceService().checkIn(
        employeeId: employeeId,
        imageFile: imageFile,
        latitude: latitude,
        longitude: longitude,
        deviceId: 'mobile-app',
      );

      return response;
    } catch (e) {
      String errorMessage = e.toString();

      // Ensure error message is in Vietnamese
      if (!errorMessage.contains('Không thể') &&
          !errorMessage.contains('Vui lòng') &&
          !errorMessage.contains('Lỗi') &&
          !errorMessage.contains('không')) {
        errorMessage = 'Lỗi: $errorMessage';
      }

      return {'success': false, 'message': errorMessage};
    }
  }

  Future<Map<String, dynamic>> _callCheckOutAPI({
    required double latitude,
    required double longitude,
  }) async {
    try {
      // Get employee ID from auth context via Riverpod
      final user = ref.read(userProvider);

      if (user == null || user.employee?.id == null) {
        return {
          'success': false,
          'message':
              'Không thể lấy thông tin nhân viên. Vui lòng đăng nhập lại.',
        };
      }

      final String employeeId = user.employee!.id;

      final response = await AttendanceService().checkOut(
        employeeId: employeeId,
        latitude: latitude,
        longitude: longitude,
        deviceId: 'mobile-app',
      );

      // Check if response has success field, if not assume it's successful (for DailyAttendance)
      if (response is Map<String, dynamic>) {
        if (response.containsKey('success')) {
          return response;
        } else {
          // If no success field, assume successful if no error
          return {
            'success': true,
            'data': response,
            'message': 'Kết thúc chấm công thành công',
          };
        }
      }

      return {
        'success': true,
        'data': response,
        'message': 'Kết thúc chấm công thành công',
      };
    } catch (e) {
      // If exception is thrown, it's an error
      String errorMessage = e.toString();

      // Extract meaningful error message from exception
      if (errorMessage.contains('Không tìm thấy bản ghi chấm công')) {
        errorMessage =
            'Không tìm thấy bản ghi chấm công hôm nay. Vui lòng chấm công (check-in) trước.';
      } else if (errorMessage.contains('đã kết thúc chấm công')) {
        errorMessage = 'Bạn đã kết thúc chấm công rồi.';
      } else if (!errorMessage.contains('Không thể') &&
          !errorMessage.contains('Vui lòng')) {
        errorMessage = 'Lỗi: $errorMessage';
      }

      return {'success': false, 'message': errorMessage};
    }
  }

  /// Format ISO datetime string or datetime value to HH:mm format
  String _formatTime(dynamic timeValue) {
    if (timeValue == null) return '--:--';

    try {
      DateTime dateTime;

      if (timeValue is String) {
        // Parse ISO datetime string
        dateTime = DateTime.parse(timeValue);
      } else if (timeValue is DateTime) {
        dateTime = timeValue;
      } else {
        return '--:--';
      }

      // Format as HH:mm
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '--:--';
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Loading state
    if (_isLoadingShiftData) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Đang tải dữ liệu...',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // Error state
    if (_employeeData == null || _shiftData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.red[700], size: 48),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _errorMessage ?? 'Lỗi tải dữ liệu',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red[700]),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadShiftData,
              icon: const Icon(Icons.refresh),
              label: const Text('Thử lại'),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [_buildWorkTimeSection(), _buildLocationInfoSection()],
      ),
    );
  }

  Widget _buildWorkTimeSection() {
    final employeeData = _employeeData!;
    final shiftData = _shiftData!;

    // Extract values
    final officeLocation =
        employeeData['officeLocation'] as Map<String, dynamic>?;
    final officeAddress = officeLocation?['address'] ?? 'Chưa có địa điểm';
    final requiredDistance = officeLocation?['radius'] ?? 500;

    final shiftName = shiftData['name'] ?? 'N/A';
    final shiftStartTime = shiftData['startTime'] ?? '08:00';
    final shiftEndTime = shiftData['endTime'] ?? '17:00';
    final checkInTime = shiftData['checkInTime'];
    final checkOutTime = shiftData['checkOutTime'];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'THỜI GIAN LÀM VIỆC',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Ca làm việc
          _buildDetailRow(
            'Ca làm việc',
            '$shiftName ($shiftStartTime - $shiftEndTime)',
          ),
          const SizedBox(height: 16),

          // Địa điểm
          _buildDetailRow('Địa điểm', officeAddress, isMultiLine: true),
          const SizedBox(height: 16),

          // Divider
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Khoảng cách section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khoảng cách hiện tại',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.teal[100]!),
                      ),
                      child: Text(
                        _calculatedDistance != null
                            ? '${_calculatedDistance!.toStringAsFixed(0)} m'
                            : 'N/A',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Khoảng cách yêu cầu',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$requiredDistance m',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: _isCheckingLocation ? null : _checkCurrentLocation,
                icon: Icon(
                  _isCheckingLocation
                      ? Icons.hourglass_bottom
                      : Icons.location_on,
                  size: 16,
                ),
                label: Text(
                  _isCheckingLocation ? 'Cập nhật...' : 'Cập nhật',
                  style: const TextStyle(fontSize: 11),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Divider
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Camera Preview
          Container(
            height: 220,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[100],
            ),
            child:
                _cameraController != null &&
                    _cameraController!.value.isInitialized
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CameraPreview(_cameraController!),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 56,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Đang khởi tạo camera...',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 20),

          // Time boxes with better styling
          _buildTimeBoxesStyled(checkInTime, checkOutTime),

          // Error/Success messages with better styling
          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red[700], size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (_successMessage != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Colors.green[700],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _successMessage!,
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeBoxesStyled(dynamic checkInTime, dynamic checkOutTime) {
    return Column(
      children: [
        // Time boxes
        Row(
          children: [
            // Check-in box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[50]!, Colors.blue[100]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[300]!, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.login, color: Colors.blue[700], size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Giờ vào',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatTime(checkInTime),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (checkInTime == null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _performCheckIn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Check In',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Check-out box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.orange[50]!, Colors.orange[100]!],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange[300]!, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.logout, color: Colors.orange[700], size: 16),
                        const SizedBox(width: 6),
                        Text(
                          'Giờ ra',
                          style: TextStyle(
                            color: Colors.orange[700],
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _formatTime(checkOutTime),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (checkInTime != null && checkOutTime == null)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _performCheckOut,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            elevation: 2,
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Text(
                                  'Check Out',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationInfoSection() {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'THÔNG TIN ĐỊNH VỊ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // IP Address
          _buildDetailRow('IP Address', _deviceIP ?? 'Chưa xác định'),
          const SizedBox(height: 16),

          // Coordinates
          if (_currentLatitude != null && _currentLongitude != null) ...[
            _buildDetailRow('Kinh độ', _currentLatitude!.toStringAsFixed(6)),
            const SizedBox(height: 16),
            _buildDetailRow('Vĩ độ', _currentLongitude!.toStringAsFixed(6)),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String? value, {
    bool isMultiLine = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            value ?? 'N/A',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Colors.black87,
            ),
            maxLines: isMultiLine ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
    String label,
    String? value, {
    bool isMultiLine = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value ?? 'N/A',
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          maxLines: isMultiLine ? 3 : 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
