import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../src/config/constants.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  String? _token;
  
  Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString(AppConstants.tokenKey);
    return _token;
  }

  Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
    await prefs.remove(AppConstants.userIdKey);
    await prefs.remove(AppConstants.userEmailKey);
    await prefs.remove(AppConstants.userNameKey);
  }

  Map<String, String> _getHeaders({bool includeAuth = false}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (includeAuth && _token != null) {
      headers['Authorization'] = 'Bearer $_token';
    }
    
    return headers;
  }

  Future<http.Response> get(String endpoint, {bool requireAuth = true}) async {
    if (requireAuth) {
      await getToken();
    }
    
    try {
      final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
      print('🌐 API GET: ${url.toString()}');
      print('🔑 Token: ${_token != null ? "***" : "null"}');
      
      final response = await http.get(
        url,
        headers: _getHeaders(includeAuth: requireAuth),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout - server tidak merespons dalam 10 detik');
        },
      );
      
      print('📥 Response Status: ${response.statusCode}');
      print('📥 Response Body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}');
      
      return response;
    } catch (e) {
      print('❌ API Error: $e');
      // Re-throw dengan informasi yang lebih jelas
      if (e.toString().contains('TimeoutException') || e.toString().contains('timeout')) {
        throw Exception('Request timeout - server tidak merespons');
      }
      rethrow;
    }
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body, {bool requireAuth = false}) async {
    if (requireAuth) {
      await getToken();
    }
    
    try {
      final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
      final response = await http.post(
        url,
        headers: _getHeaders(includeAuth: requireAuth),
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout - server tidak merespons dalam 10 detik');
        },
      );
      return response;
    } catch (e) {
      // Re-throw dengan informasi yang lebih jelas
      if (e.toString().contains('TimeoutException') || e.toString().contains('timeout')) {
        throw Exception('Request timeout - server tidak merespons');
      }
      rethrow;
    }
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body, {bool requireAuth = true}) async {
    if (requireAuth) {
      await getToken();
    }
    
    try {
      final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
      final response = await http.put(
        url,
        headers: _getHeaders(includeAuth: requireAuth),
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout - server tidak merespons dalam 10 detik');
        },
      );
      return response;
    } catch (e) {
      if (e.toString().contains('TimeoutException') || e.toString().contains('timeout')) {
        throw Exception('Request timeout - server tidak merespons');
      }
      rethrow;
    }
  }

  Future<http.Response> delete(String endpoint, {bool requireAuth = true}) async {
    if (requireAuth) {
      await getToken();
    }
    
    try {
      final url = Uri.parse('${AppConstants.baseUrl}$endpoint');
      final response = await http.delete(
        url,
        headers: _getHeaders(includeAuth: requireAuth),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout - server tidak merespons dalam 10 detik');
        },
      );
      return response;
    } catch (e) {
      if (e.toString().contains('TimeoutException') || e.toString().contains('timeout')) {
        throw Exception('Request timeout - server tidak merespons');
      }
      rethrow;
    }
  }
}

