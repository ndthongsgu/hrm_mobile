import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:hrm_mobile/config/theme.dart';
import 'package:hrm_mobile/features/attendance/data/services/attendance_service.dart';
import 'package:hrm_mobile/features/auth/auth_provider.dart';
import 'package:hrm_mobile/features/auth/models/auth_models.dart';

class AttendanceBoardScreen extends ConsumerStatefulWidget {
  const AttendanceBoardScreen({super.key});

  @override
  ConsumerState<AttendanceBoardScreen> createState() =>
      _AttendanceBoardScreenState();
}

class _AttendanceBoardScreenState extends ConsumerState<AttendanceBoardScreen> {
  late DateTime _currentMonth;
  Map<DateTime, AttendanceStatus> _attendanceData = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
    _loadAttendanceData();
  }

  Future<void> _loadAttendanceData() async {
    setState(() => _isLoading = true);

    try {
      // Get employee ID from auth service (same pattern as attendance_screen)
      final user = ref.read(userProvider);
      
      if (user == null || user.employee?.id == null) {
        throw Exception('Không tìm thấy ID nhân viên. Vui lòng đăng nhập lại.');
      }
      
      final employeeId = user.employee!.id;
      
      final data = await _fetchMonthlyAttendance(
        employeeId,
        _currentMonth.year,
        _currentMonth.month,
      );
      
      setState(() {
        _attendanceData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi tải dữ liệu: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<Map<DateTime, AttendanceStatus>> _fetchMonthlyAttendance(
    String employeeId,
    int year,
    int month,
  ) async {
    try {
      final service = AttendanceService();
      final response = await service.getMonthlyAttendance(
        employeeId,
        year,
        month,
      );

      final dailyRecords = response['dailyRecords'] as List<dynamic>;
      final attendanceData = <DateTime, AttendanceStatus>{};

      for (var record in dailyRecords) {
        final date = DateTime.parse(record['date']);
        final status = record['status'] as String;
        final lateMinutes = record['lateMinutes'] as int? ?? 0;
        final earlyMinutes = record['earlyMinutes'] as int? ?? 0;

        AttendanceStatus attendanceStatus;

        // Map backend status to frontend enum
        switch (status) {
          case 'ABSENT':
            attendanceStatus = AttendanceStatus.absent;
            break;
          case 'LEAVE':
            // Skip leave days (paid leave)
            continue;
          case 'OK':
          case 'LATE':
            if (lateMinutes > 0) {
              attendanceStatus = AttendanceStatus.late;
            } else if (earlyMinutes > 0) {
              attendanceStatus = AttendanceStatus.leftEarly;
            } else {
              attendanceStatus = AttendanceStatus.onTime;
            }
            break;
          default:
            attendanceStatus = AttendanceStatus.onTime;
        }

        attendanceData[date] = attendanceStatus;
      }

      return attendanceData;
    } catch (e) {
      rethrow;
    }
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
    _loadAttendanceData();
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
    _loadAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [_buildCalendarSection(), _buildStatisticsSection()],
              ),
            ),
    );
  }

  Widget _buildCalendarSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month header with navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
                color: Colors.teal,
              ),
              Text(
                DateFormat('MMMM - yyyy').format(_currentMonth),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
                color: Colors.teal,
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Day of week headers
          _buildDayOfWeekHeaders(),
          const SizedBox(height: 12),

          // Calendar grid
          _buildCalendarGrid(),
          const SizedBox(height: 20),

          // Legend
          _buildLegend(),
        ],
      ),
    );
  }

  Widget _buildDayOfWeekHeaders() {
    final dayLabels = ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dayLabels
          .map(
            (label) => Expanded(
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDay = DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final firstWeekday = firstDay.weekday % 7; // 0 = Sunday

    final rows = <List<int>>[];
    List<int> currentRow = List.filled(7, 0);

    // Fill first row with empty cells and starting days
    for (int i = firstWeekday; i < 7; i++) {
      currentRow[i] = i - firstWeekday + 1;
    }
    rows.add(currentRow);

    // Fill remaining rows
    int day = 8 - firstWeekday;
    while (day <= lastDay.day) {
      currentRow = List.filled(7, 0);
      for (int i = 0; i < 7 && day <= lastDay.day; i++) {
        currentRow[i] = day++;
      }
      rows.add(currentRow);
    }

    return Column(
      children: rows
          .map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: row
                    .map((day) => Expanded(child: _buildDayCell(day)))
                    .toList(),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDayCell(int day) {
    if (day == 0) {
      return const SizedBox.square(dimension: 40);
    }

    final date = DateTime(_currentMonth.year, _currentMonth.month, day);
    final status = _attendanceData[date];

    Color backgroundColor = Colors.transparent;
    Color textColor = Colors.black87;

    if (status != null) {
      switch (status) {
        case AttendanceStatus.onTime:
          backgroundColor = const Color(0xFF4CAF50); // Green
          textColor = Colors.white;
          break;
        case AttendanceStatus.late:
          backgroundColor = const Color(0xFFFFA500); // Orange
          textColor = Colors.white;
          break;
        case AttendanceStatus.leftEarly:
          backgroundColor = const Color(0xFF9C27B0); // Purple
          textColor = Colors.white;
          break;
        case AttendanceStatus.absent:
          backgroundColor = const Color(0xFFE57373); // Red
          textColor = Colors.white;
          break;
      }
    }

    return Center(
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: status == null ? Border.all(color: Colors.grey[300]!) : null,
        ),
        child: Center(
          child: Text(
            day.toString(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    final legends = [
      (AttendanceStatus.onTime, 'Đúng giờ'),
      (AttendanceStatus.late, 'Đi muộn'),
      (AttendanceStatus.leftEarly, 'Về sớm'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: legends
            .map(
              (legend) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getStatusColor(legend.$1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    legend.$2,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    final stats = _calculateStatistics();

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
                'THỐNG KÊ CÔNG THÁNG',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(),
              Icon(Icons.show_chart, color: Colors.teal[300], size: 20),
            ],
          ),
          const SizedBox(height: 20),

          // Statistics rows
          _buildStatRow('Ngày công', stats['totalDays'].toString()),
          const SizedBox(height: 12),
          _buildStatRow(
            'Đúng giờ',
            stats['onTime'].toString(),
            color: const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 12),
          _buildStatRow(
            'Đi muộn',
            stats['late'].toString(),
            color: const Color(0xFFFFA500),
          ),
          const SizedBox(height: 12),
          _buildStatRow(
            'Về sớm',
            stats['leftEarly'].toString(),
            color: const Color(0xFF9C27B0),
          ),
          const SizedBox(height: 12),
          _buildStatRow(
            'Vắng mặt',
            stats['absent'].toString(),
            color: const Color(0xFFE57373),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, {Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (color != null) ...[
              Container(
                width: 3,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(width: 12),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Map<String, int> _calculateStatistics() {
    int totalDays = 0;
    int onTime = 0;
    int late = 0;
    int leftEarly = 0;
    int absent = 0;

    _attendanceData.forEach((date, status) {
      totalDays++;
      switch (status) {
        case AttendanceStatus.onTime:
          onTime++;
          break;
        case AttendanceStatus.late:
          late++;
          break;
        case AttendanceStatus.leftEarly:
          leftEarly++;
          break;
        case AttendanceStatus.absent:
          absent++;
          break;
      }
    });

    return {
      'totalDays': totalDays,
      'onTime': onTime,
      'late': late,
      'leftEarly': leftEarly,
      'absent': absent,
    };
  }

  Color _getStatusColor(AttendanceStatus status) {
    switch (status) {
      case AttendanceStatus.onTime:
        return const Color(0xFF4CAF50);
      case AttendanceStatus.late:
        return const Color(0xFFFFA500);
      case AttendanceStatus.leftEarly:
        return const Color(0xFF9C27B0);
      case AttendanceStatus.absent:
        return const Color(0xFFE57373);
    }
  }
}

enum AttendanceStatus { onTime, late, leftEarly, absent }
