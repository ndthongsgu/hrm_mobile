import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../../data/repositories/payroll_repository.dart';
import '../../data/models/payroll_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final payrollRepositoryProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return PayrollRepository(apiService);
});

// Get payroll by employee
final employeePayrollProvider = FutureProvider.family<
    List<Payroll>,
    (String employeeId, int? month, int? year)>((ref, params) async {
  final repository = ref.watch(payrollRepositoryProvider);
  return repository.getPayrollByEmployeeId(
    params.$1,
    month: params.$2,
    year: params.$3,
  );
});

// Get payroll summary
final payrollSummaryProvider =
    FutureProvider.family<PayrollSummary, (int month, int year)>((ref, params) async {
  final repository = ref.watch(payrollRepositoryProvider);
  return repository.getPayrollSummary(params.$1, params.$2);
});

// Create payroll
final createPayrollProvider =
    FutureProvider.family<Payroll, Payroll>((ref, payroll) async {
  final repository = ref.watch(payrollRepositoryProvider);
  return repository.createPayroll(payroll);
});

// Update payroll
final updatePayrollProvider =
    FutureProvider.family<Payroll, Payroll>((ref, payroll) async {
  final repository = ref.watch(payrollRepositoryProvider);
  return repository.updatePayroll(payroll);
});

// Generate monthly payroll
final generateMonthlyPayrollProvider =
    FutureProvider.family<List<Payroll>, (int month, int year)>((ref, params) async {
  final repository = ref.watch(payrollRepositoryProvider);
  return repository.generateMonthlyPayroll(params.$1, params.$2);
});
