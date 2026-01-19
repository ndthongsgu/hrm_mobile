import '../../../../core/services/api_service.dart';
import '../models/employee_model.dart';

class ProfileRepository {
  final ApiService _apiService;

  ProfileRepository(this._apiService);

  Future<Employee> getEmployeeById(String employeeId) async {
    try {
      final data = await _apiService.get('/api/employees/$employeeId');

      return Employee.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Employee>> getAllEmployees() async {
    try {
      final data = await _apiService.get('/api/employees');
      if (data is List) {
        return data.map((json) => Employee.fromJson(json as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> createEmployee(Employee employee) async {
    try {
      final payload = {
        'full_name': employee.fullName,
        'email': employee.email,
        'phone_number': employee.phoneNumber,
        'date_of_birth': employee.dateOfBirth.toIso8601String(),
        'gender': employee.gender,
        'address': employee.address,
        'position': employee.position,
        'department': employee.department,
        'hire_date': employee.hireDate.toIso8601String(),
        'avatar_url': employee.avatarUrl,
        'status': employee.status,
      };

      final data = await _apiService.post('/api/employees', data: payload);
      return Employee.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> updateEmployee(Employee employee) async {
    try {
      final payload = {
        'full_name': employee.fullName,
        'phone_number': employee.phoneNumber,
        'address': employee.address,
        'position': employee.position,
        'department': employee.department,
        'avatar_url': employee.avatarUrl,
        'status': employee.status,
      };

      final data = await _apiService.put('/api/employees/${employee.id}', data: payload);
      return Employee.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<EmployeeDetail> getEmployeeDetail(String employeeId) async {
    try {
      final data = await _apiService.get('/api/employees/$employeeId/detail');

      if (data == null) {
        final employee = await getEmployeeById(employeeId);
        return EmployeeDetail(employee: employee);
      }

      return EmployeeDetail.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
