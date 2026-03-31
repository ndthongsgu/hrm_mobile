import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hrm_mobile/config/theme.dart';
import 'package:hrm_mobile/features/auth/auth_provider.dart';
import 'package:hrm_mobile/features/auth/models/auth_models.dart';
import 'package:hrm_mobile/routes/app_routes.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  UserProfile? _profile;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final authService = ref.read(authServiceProvider);
      final profile = await authService.getMyProfile();

      if (!mounted) {
        return;
      }

      setState(() {
        _profile = profile;
        _usernameController.text = profile.username;
        _fullNameController.text = profile.displayName;
        _emailController.text = profile.displayEmail;
        _phoneController.text = profile.displayPhone ?? '';
        _addressController.text = profile.displayAddress ?? '';
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể tải hồ sơ: ${_cleanError(e)}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_profile == null) {
      return;
    }

    final username = _usernameController.text.trim();
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final address = _addressController.text.trim();

    final request = UpdateMyProfileRequest(
      username: username != _profile!.username ? username : null,
      fullName: fullName != _profile!.displayName ? fullName : null,
      email: email != _profile!.displayEmail ? email : null,
      phone: phone != (_profile!.displayPhone ?? '') ? phone : null,
      address: address != (_profile!.displayAddress ?? '') ? address : null,
    );

    final payload = request.toJson();
    if (payload.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không có thay đổi để cập nhật')),
      );
      return;
    }

    setState(() => _isSaving = true);
    try {
      final authService = ref.read(authServiceProvider);
      final updatedProfile = await authService.updateMyProfile(request);

      if (!mounted) {
        return;
      }

      setState(() {
        _profile = updatedProfile;
        _usernameController.text = updatedProfile.username;
        _fullNameController.text = updatedProfile.displayName;
        _emailController.text = updatedProfile.displayEmail;
        _phoneController.text = updatedProfile.displayPhone ?? '';
        _addressController.text = updatedProfile.displayAddress ?? '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật hồ sơ thành công')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cập nhật thất bại: ${_cleanError(e)}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _logout() async {
    try {
      await ref.read(authServiceProvider).logout();
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (_) {
      if (mounted) {
        Get.offAllNamed(AppRoutes.login);
      }
    }
  }

  String _cleanError(Object e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadProfile,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
                          child: const Icon(
                            Icons.person,
                            size: 48,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        context,
                        'Thông tin tài khoản',
                        [
                          _buildTextField(
                            controller: _usernameController,
                            label: 'Tên đăng nhập',
                            icon: Icons.person_outline,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Tên đăng nhập không được để trống';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _fullNameController,
                            label: 'Họ và tên',
                            icon: Icons.badge_outlined,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Họ và tên không được để trống';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _emailController,
                            label: 'Email',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Email không được để trống';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildSection(
                        context,
                        'Thông tin liên hệ',
                        [
                          _buildTextField(
                            controller: _phoneController,
                            label: 'Số điện thoại',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 12),
                          _buildTextField(
                            controller: _addressController,
                            label: 'Địa chỉ',
                            icon: Icons.location_on_outlined,
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isSaving ? null : _saveProfile,
                          child: _isSaving
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor:
                                        AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Lưu thay đổi'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 48,
                        child: OutlinedButton.icon(
                          onPressed: _logout,
                          icon: const Icon(Icons.logout),
                          label: const Text('Đăng xuất'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
      ),
    );
  }
}
