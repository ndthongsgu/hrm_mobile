import '../../../../core/services/api_service.dart';
import '../models/payroll_model.dart';

class PayrollRepository {
  final ApiService _apiService;

  PayrollRepository(this._apiService);

  Future<List<Payroll>> getPayrollByEmployeeId(
    String employeeId, {
    int? month,
    int? year,
  }) async {
    try {
      final query = {
        'employee_id': employeeId,
        if (month != null) 'month': month,
        if (year != null) 'year': year,
      };

      final data = await _apiService.get('/api/payroll', queryParameters: query);

      if (data is List) {
        return data.map((json) => Payroll.fromJson(json as Map<String, dynamic>)).toList();
      }

      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<Payroll> createPayroll(Payroll payroll) async {
    try {
      final payload = {
        'employee_id': payroll.employeeId,
        'employee_name': payroll.employeeName,
        'month': payroll.month,
        'year': payroll.year,
        'basic_salary': payroll.basicSalary,
        'allowance': payroll.allowance,
        'bonus': payroll.bonus,
        'bhxh': payroll.bhxh,
        'personal_income_tax': payroll.personalIncomeTax,
        'other_deductions': payroll.otherDeductions,
        'total_deductions': payroll.totalDeductions,
        'net_salary': payroll.netSalary,
        'status': payroll.status,
        'notes': payroll.notes,
        'pdf_url': payroll.pdfUrl,
      };

      final data = await _apiService.post('/api/payroll', data: payload);

      return Payroll.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<Payroll> updatePayroll(Payroll payroll) async {
    try {
      final payload = {
        'status': payroll.status,
        'notes': payroll.notes,
        'pdf_url': payroll.pdfUrl,
        'paid_date': payroll.paidDate?.toIso8601String(),
      };

      final data = await _apiService.put('/api/payroll/${payroll.id}', data: payload);

      return Payroll.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Payroll>> generateMonthlyPayroll(int month, int year) async {
    try {
      final data = await _apiService.post('/api/payroll/generate', data: {
        'month': month,
        'year': year,
      });

      if (data is List) {
        return data.map((e) => Payroll.fromJson(e as Map<String, dynamic>)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<PayrollSummary> getPayrollSummary(int month, int year) async {
    try {
      final data = await _apiService.get('/api/payroll/summary', queryParameters: {
        'month': month,
        'year': year,
      });

      return PayrollSummary.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePayroll(String payrollId) async {
    try {
      await _apiService.delete('/api/payroll/$payrollId');
    } catch (e) {
      rethrow;
    }
  }
}
