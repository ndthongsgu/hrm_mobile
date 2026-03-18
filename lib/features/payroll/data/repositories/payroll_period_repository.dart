import 'package:hrm_mobile/core/services/api_service.dart';
import '../../models/select_option_dto.dart';

class PayrollPeriodRepository {
  final ApiService apiService;

  PayrollPeriodRepository({required this.apiService});

  Future<List<SelectOptionDto>> getMobileSelectOptions() async {
    try {
      final response = await apiService.get('/api/payroll-periods/mobile-select-options');
      
      // Extract data from BaseResponse structure
      final data = response['data'] as List? ?? [];
      
      return (data as List)
          .map((item) => SelectOptionDto.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch payroll periods: $e');
    }
  }
}
