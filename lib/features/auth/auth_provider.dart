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

// Auth State Notifier
class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(_authService.isAuthenticated);

  void updateAuthState() {
    state = _authService.isAuthenticated;
  }

  Future<void> logout() async {
    await _authService.logout();
    state = false;
  }
}

// User Profile Notifier
class UserNotifier extends StateNotifier<UserProfile?> {
  final AuthService _authService;

  UserNotifier(this._authService) : super(null) {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    if (_authService.isAuthenticated) {
      try {
        final profile = await _authService.getMyProfile();
        state = profile;
      } catch (e) {
        // Handle error
        state = null;
      }
    } else {
      state = null;
    }
  }

  void updateProfile(UserProfile profile) {
    state = profile;
  }

  void clearProfile() {
    state = null;
  }
}

// Auth State Provider
final authStateProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService);
});

// User Profile Provider
final userProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return UserNotifier(authService);
});

// Login Provider
final loginProvider = FutureProvider.family<LoginResponse, (String, String)>(
  (ref, params) async {
    final authService = ref.watch(authServiceProvider);
    final (username, password) = params;
    final response = await authService.login(username, password);
    // Update auth state after successful login
    ref.read(authStateProvider.notifier).updateAuthState();
    // Load user profile
    await ref.read(userProvider.notifier).loadUserProfile();
    return response;
  },
);
