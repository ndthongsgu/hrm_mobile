import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/api_service.dart';
import 'services/auth_service.dart';
import 'models/auth_models.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Auth Service Provider
final authServiceProvider = Provider<AuthService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthService(apiService: apiService);
});

// Login Provider
final loginProvider = FutureProvider.family<LoginResponse, (String, String)>(
  (ref, params) async {
    final authService = ref.watch(authServiceProvider);
    final (username, password) = params;
    return authService.login(username, password);
  },
);

// Change Password Provider
final changePasswordProvider = FutureProvider.family<void, (String, String)>(
  (ref, params) async {
    final authService = ref.watch(authServiceProvider);
    final (currentPassword, newPassword) = params;
    return authService.changePassword(currentPassword, newPassword);
  },
);

// Forgot Password Provider
final forgotPasswordProvider =
    FutureProvider.family<ForgotPasswordResponse, String>(
  (ref, email) async {
    final authService = ref.watch(authServiceProvider);
    return authService.forgotPassword(email);
  },
);

// Auth State Provider
final authStateProvider = StateProvider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.isAuthenticated;
});
