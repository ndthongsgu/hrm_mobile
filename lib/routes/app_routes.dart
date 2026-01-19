import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../features/attendance/presentation/screens/attendance_screen.dart';
import '../features/payroll/presentation/screens/payroll_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/contract/presentation/screens/contract_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/home_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String attendance = '/attendance';
  static const String payroll = '/payroll';
  static const String profile = '/profile';
  static const String contract = '/contract';
  static const String qrScanner = '/qr-scanner';

  static final Map<String, WidgetBuilder> routes = {
    login: (context) => const LoginScreen(),
    home: (context) => const HomeScreen(),
    attendance: (context) => const AttendanceScreen(),
    payroll: (context) => const PayrollScreen(),
    profile: (context) => const ProfileScreen(),
    contract: (context) => const ContractScreen(),
  };

  static final List<GetPage> getPages = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: attendance,
      page: () => const AttendanceScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: payroll,
      page: () => const PayrollScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: contract,
      page: () => const ContractScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
