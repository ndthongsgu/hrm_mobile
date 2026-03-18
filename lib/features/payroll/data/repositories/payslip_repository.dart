import 'package:hrm_mobile/core/services/api_service.dart';
import '../../models/payslip_model.dart';

class PayslipRepository {
  final ApiService apiService;

  PayslipRepository({required this.apiService});

  Future<PayslipModel> getPayslipByEmployeeAndPeriod(
    String employeeId,
    String payrollPeriodId,
  ) async {
    try {
      final response = await apiService.get(
        '/api/payslips/employee/$employeeId/payroll-period/$payrollPeriodId',
      );

      // Extract data from BaseResponse structure
      final data = response['data'] as Map<String, dynamic>? ?? {};

      return PayslipModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch payslip: $e');
    }
  }
}
