import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  static const String appName = "SIAKAD FTUMT";
  static const String slogan = "Sistem Akademik";
  static const String logoPath = "assets/images/logo_umt.png";
  
  // API Configuration
  // Reads from --dart-define if provided, otherwise fallback by platform
  static String get baseUrl {
    const defineUrl = String.fromEnvironment('API_BASE_URL');
    if (defineUrl.isNotEmpty) {
      return defineUrl;
    }

    if (kIsWeb) {
      // Web can use localhost
      return "http://localhost:8080/api";
    }

    // Default for Android emulator; for physical device, pass --dart-define
    return "http://10.0.2.2:8080/api";
  }
  
  // Shared Preferences Keys
  static const String tokenKey = "auth_token";
  static const String userIdKey = "user_id";
  static const String userEmailKey = "user_email";
  static const String userNameKey = "user_name";
}
