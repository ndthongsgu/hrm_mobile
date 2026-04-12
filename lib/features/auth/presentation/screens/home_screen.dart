import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hrm_mobile/config/theme.dart';
import 'package:hrm_mobile/routes/app_routes.dart';
import '../../models/auth_models.dart';
import '../../auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  UserProfile? _profile;

  final List<MenuItem> menuItems = [
    MenuItem(
      title: 'Chấm công',
      icon: Icons.check_circle_outline,
      route: AppRoutes.attendance,
      color: Colors.blue,
    ),
    MenuItem(
      title: 'Lương',
      icon: Icons.attach_money_outlined,
      route: AppRoutes.payroll,
      color: Colors.green,
    ),
    MenuItem(
      title: 'Hợp đồng',
      icon: Icons.description_outlined,
      route: AppRoutes.contract,
      color: Colors.orange,
    ),
    MenuItem(
      title: 'Hồ sơ',
      icon: Icons.person_outline,
      route: AppRoutes.profile,
      color: Colors.purple,
    ),
  ];

  void _handleChangePassword() {
    Get.toNamed(AppRoutes.changePassword);
  }

  @override
  void initState() {
    super.initState();
    _loadMyProfile();
  }

  Future<void> _loadMyProfile() async {
    try {
      final profile = await ref.read(authServiceProvider).getMyProfile();
      if (!mounted) {
        return;
      }
      setState(() {
        _profile = profile;
      });
    } catch (_) {
      // Keep fallback name from local storage below when API is unavailable.
    }
  }

  String _resolveGreetingName() {
    final fromApi = _profile?.displayName.trim() ?? '';
    if (fromApi.isNotEmpty) {
      return fromApi;
    }

    final user = ref.read(userProvider);
    final localName = user?.name.trim() ?? '';
    if (localName.isNotEmpty) {
      return localName;
    }

    return 'Nhân viên';
  }

  Future<void> _handleLogout() async {
    Get.dialog(
      AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Bạn có chắc muốn đăng xuất?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              try {
                final authService = ref.read(authServiceProvider);
                await authService.logout();
                Get.offNamed(AppRoutes.login);
              } catch (e) {
                Get.snackbar('Lỗi', 'Không thể đăng xuất');
              }
            },
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _resolveGreetingName();

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('HRM Mobile'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Get.snackbar('Thông báo', 'Chưa có thông báo mới');
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'change_password') {
                _handleChangePassword();
              } else if (value == 'logout') {
                _handleLogout();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'change_password',
                child: Row(
                  children: [
                    Icon(Icons.lock_outlined, size: 20),
                    SizedBox(width: 12),
                    Text('Đổi mật khẩu'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20, color: Colors.red),
                    SizedBox(width: 12),
                    Text('Đăng xuất', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chào buổi sáng',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              'Tính năng chính',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.spacing12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppTheme.spacing12,
                mainAxisSpacing: AppTheme.spacing12,
              ),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                return _buildMenuCard(context, item);
              },
            ),
            const SizedBox(height: AppTheme.spacing24),
            Text(
              'Thông tin nhanh',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.spacing12),
            Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: const Icon(Icons.check_circle, color: Colors.blue),
                ),
                title: const Text('Chấm công hôm nay'),
                subtitle: const Text('Có mặt'),
                trailing: const Text('08:30'),
              ),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Card(
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: const Icon(Icons.attach_money,
                      color: Colors.green),
                ),
                title: const Text('Lương tháng này'),
                subtitle: const Text('15.000.000 ₫'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            ),
            const SizedBox(height: AppTheme.spacing32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, MenuItem item) {
    return GestureDetector(
      onTap: () => Get.toNamed(item.route),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 32,
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final String route;
  final Color color;

  MenuItem({
    required this.title,
    required this.icon,
    required this.route,
    required this.color,
  });
}
