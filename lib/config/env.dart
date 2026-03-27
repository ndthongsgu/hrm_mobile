class Environment {
  // API Configuration
  // Set your backend API base URL (required)
  // static const String apiBaseUrl = 'http://localhost:8080';
  static const String apiBaseUrl = 'https://unsuccinctly-unadhering-zenaida.ngrok-free.dev';
  static const Duration apiTimeoutDuration = Duration(seconds: 30);

  // GPS and Location Configuration
  static const Duration gpsLocationTimeout = Duration(seconds: 15);
  static const Duration gpsFallbackTimeout = Duration(seconds: 20);
  static const Duration gpsFallbackDurationLimit = Duration(seconds: 10);

  // Database: use a PostgreSQL instance managed by your backend.
  // Supabase is optional as a managed Postgres provider but not required by the app.
  
  // Firebase Configuration (optional for notifications)
  static const String firebaseProjectId = 'YOUR_FIREBASE_PROJECT_ID';
  
  // App Configuration
  static const String appName = 'HRM Mobile';
  static const String appVersion = '1.0.0';
  static const bool isProduction = false;
  
  // Feature Flags
  static const bool enableOfflineMode = true;
  static const bool enableQRCodeScanning = true;
  static const bool enablePDFExport = true;
}
