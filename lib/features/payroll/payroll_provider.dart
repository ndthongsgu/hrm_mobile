import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hrm_mobile/core/services/api_service.dart';
import 'package:hrm_mobile/features/auth/services/auth_service.dart';
import 'data/repositories/payroll_period_repository.dart';
import 'data/repositories/payslip_repository.dart';
import 'models/select_option_dto.dart';
import 'models/payslip_model.dart';

// ApiService provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// AuthService provider
final authServiceProvider = Provider<AuthService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthService(apiService: apiService);
});

// PayrollPeriodRepository provider
final payrollPeriodRepositoryProvider = Provider<PayrollPeriodRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PayrollPeriodRepository(apiService: apiService);
});

// PayslipRepository provider
final payslipRepositoryProvider = Provider<PayslipRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PayslipRepository(apiService: apiService);
});

// Payroll periods select options provider
final payrollPeriodsProvider = FutureProvider<List<SelectOptionDto>>((ref) async {
  final repository = ref.watch(payrollPeriodRepositoryProvider);
  return repository.getMobileSelectOptions();
});

// Payslip provider - requires employeeId and payrollPeriodId as parameters
final payslipProvider = FutureProvider.family<PayslipModel, ({String employeeId, String payrollPeriodId})>((ref, params) async {
  final repository = ref.watch(payslipRepositoryProvider);
  
  // Validate parameters
  final employeeId = params.employeeId.trim();
  final payrollPeriodId = params.payrollPeriodId.trim();
  
  if (employeeId.isEmpty) {
    throw Exception('Employee ID is required');
  }
  if (payrollPeriodId.isEmpty) {
    throw Exception('Payroll Period ID is required');
  }
  
  return repository.getPayslipByEmployeeAndPeriod(
    employeeId,
    payrollPeriodId,
  );
});
