import 'package:flutter/foundation.dart' show kIsWeb;

class AppConstants {
  static const String appName = "SIAKAD FTUMT";
  static const String slogan = "Sistem Akademik";
  static const String logoPath = "assets/images/logo_umt.png";
  
  // API Configuration
  // Dynamic URL based on platform
  static String get baseUrl {
    if (kIsWeb) {
      // Web can use localhost
      return "http://localhost:8080/api";
    }
    // For mobile apps, assume Android emulator
    // Android emulator uses 10.0.2.2 to access host localhost
    // For physical devices, use your computer's IP address instead
    return "http://10.0.2.2:8080/api";
    
    // Alternative: If running on physical device, use:
    // return "http://192.168.0.223:8080/api";
  }
  
  // Shared Preferences Keys
  static const String tokenKey = "auth_token";
  static const String userIdKey = "user_id";
  static const String userEmailKey = "user_email";
  static const String userNameKey = "user_name";
}
