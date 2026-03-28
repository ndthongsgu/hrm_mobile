import 'package:flutter/material.dart';
import 'package:hrm_mobile/config/theme.dart';
import 'package:hrm_mobile/features/attendance/presentation/screens/attendance_screen.dart';
import 'package:hrm_mobile/features/attendance/presentation/screens/attendance_board_screen.dart';

class AttendanceMainScreen extends StatefulWidget {
  const AttendanceMainScreen({super.key});

  @override
  State<AttendanceMainScreen> createState() => _AttendanceMainScreenState();
}

class _AttendanceMainScreenState extends State<AttendanceMainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Chấm công'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.login, size: 20), text: 'Chấm công'),
            Tab(icon: Icon(Icons.calendar_month, size: 20), text: 'Bảng công'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [AttendanceScreen(), AttendanceBoardScreen()],
      ),
    );
  }
}
