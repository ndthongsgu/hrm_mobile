import 'package:dio/dio.dart';

class LocationUtils {
  static const String _publicIPApiUrl = 'https://api.ipify.org?format=json';

  /// Get device public IP address
  static Future<String> getPublicIP() async {
    try {
      final dio = Dio();
      final response = await dio.get(_publicIPApiUrl);
      if (response.statusCode == 200) {
        return response.data['ip'] ?? 'N/A';
      }
      return 'N/A';
    } catch (e) {
      // Fallback mock IP
      return '192.168.1.4';
    }
  }

  /// Format latitude/longitude to display address
  /// For now, returns a mock address based on coordinates
  /// In production, use geocoding package or backend API
  static String getAddressFromCoordinates(double latitude, double longitude) {
    // Mock implementation - returns address based on city/region
    // In production, integrate with Google Maps API or geocoding service
    
    // Check approximate location (mock)
    if (latitude > 10.8 && latitude < 10.85 && longitude > 106.7 && longitude < 106.77) {
      return '7/3D Đường Nguyễn Thị Thập, An Phú, Thủ Đức';
    } else if (latitude > 10.7 && latitude < 10.9 && longitude > 106.6 && longitude < 106.8) {
      return 'Khu vực Thủ Đức, TP. Hồ Chí Minh';
    } else {
      return 'Vị trí: ${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
    }
  }
}
