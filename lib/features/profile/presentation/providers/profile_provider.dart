import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/services/api_service.dart';
import '../../data/repositories/profile_repository.dart';
import '../../data/models/employee_model.dart';

final apiServiceProvider = Provider((ref) => ApiService());

final profileRepositoryProvider = Provider((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProfileRepository(apiService);
});

// Get employee by ID
final employeeProvider = FutureProvider.family<Employee, String>((ref, employeeId) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getEmployeeById(employeeId);
});

// Get all employees
final allEmployeesProvider = FutureProvider<List<Employee>>((ref) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getAllEmployees();
});

// Get employee detail
final employeeDetailProvider = FutureProvider.family<EmployeeDetail, String>((ref, employeeId) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getEmployeeDetail(employeeId);
});

// Create employee
final createEmployeeProvider =
    FutureProvider.family<Employee, Employee>((ref, employee) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.createEmployee(employee);
});

// Update employee
final updateEmployeeProvider =
    FutureProvider.family<Employee, Employee>((ref, employee) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.updateEmployee(employee);
});
