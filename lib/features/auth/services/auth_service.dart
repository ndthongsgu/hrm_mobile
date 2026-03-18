import 'package:get_storage/get_storage.dart';
import '../../../core/services/api_service.dart';
import '../models/auth_models.dart';

class AuthService {
  final ApiService apiService;
  late final GetStorage _storage;

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  AuthService({required this.apiService}) {
    _initStorage();
  }

  void _initStorage() {
    _storage = GetStorage();
  }

  String? get token => _storage.read(_tokenKey);
  bool get isAuthenticated => token != null;

  Future<LoginResponse> login(String username, String password) async {
    try {
      final request = LoginRequest(
        username: username,
        password: password,
      );

      final response = await apiService.post(
        '/api/auth/login',
        data: request.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response);

      // Store token and user data
      await _storage.write(_tokenKey, loginResponse.accessToken);
      await _storage.write(_userKey, {
        'id': loginResponse.id,
        'employeeId': loginResponse.employeeId,
        'username': loginResponse.username,
        'email': loginResponse.email,
        'roles': loginResponse.roles,
        'isAdmin': loginResponse.isAdmin,
      });

      // Update API service headers with token
      _updateAuthHeaders(loginResponse.accessToken);

      return loginResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final request = ChangePasswordRequest(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      await apiService.post(
        '/api/auth/change-password',
        data: request.toJson(),
      );

      // Clear tokens after successful password change
      await logout();
    } catch (e) {
      rethrow;
    }
  }

  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    try {
      final request = ForgotPasswordRequest(email: email);

      final response = await apiService.post(
        '/api/auth/forgot-password',
        data: request.toJson(),
      );

      return ForgotPasswordResponse.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await apiService.post('/api/auth/logout');
    } catch (e) {
      // Continue with logout even if API call fails
    } finally {
      await _storage.remove(_tokenKey);
      await _storage.remove(_userKey);
    }
  }

  void _updateAuthHeaders(String token) {
    // Implementation depends on your ApiService structure
    // For now, you may need to extend ApiService to support auth headers
  }

  Map<String, dynamic>? getUserData() {
    return _storage.read(_userKey);
  }
}
