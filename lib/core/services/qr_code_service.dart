import 'package:mobile_scanner/mobile_scanner.dart';

class QRCodeService {
  late MobileScannerController controller;

  QRCodeService() {
    controller = MobileScannerController(
      autoStart: false,
      torchEnabled: false,
    );
  }

  Future<void> startScanning() async {
    await controller.start();
  }

  Future<void> stopScanning() async {
    await controller.stop();
  }

  Future<void> toggleFlash() async {
    await controller.toggleTorch();
  }

  void dispose() {
    controller.dispose();
  }

  // Parse QR code data and extract employee ID
  String? extractEmployeeIdFromQR(String qrData) {
    try {
      // Expected format: "employee:12345" or just "12345"
      if (qrData.contains(':')) {
        return qrData.split(':').last;
      }
      return qrData;
    } catch (e) {
      return null;
    }
  }

  // Validate QR code format
  bool isValidEmployeeQR(String qrData) {
    final employeeId = extractEmployeeIdFromQR(qrData);
    return employeeId != null && employeeId.isNotEmpty;
  }
}
