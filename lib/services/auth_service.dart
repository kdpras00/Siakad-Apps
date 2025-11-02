import 'dart:convert';
import '../models/user_model.dart';
import '../services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/config/constants.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _apiClient.post('/auth/login', {
        'username': username,
        'password': password,
      });

      // Handle connection errors
      if (response.statusCode == 0) {
        return {
          'success': false,
          'message': 'Tidak dapat terhubung ke server. Pastikan backend sedang berjalan di port 8080.',
        };
      }

      // Parse response body
      Map<String, dynamic> data;
      try {
        data = jsonDecode(response.body);
      } catch (e) {
        return {
          'success': false,
          'message': 'Format response tidak valid dari server: ${response.body}',
        };
      }

      if (response.statusCode == 200) {
        // Verify response contains required fields
        if (data['success'] == false) {
          return {
            'success': false,
            'message': data['message'] ?? 'Login gagal',
          };
        }

        // Simpan token
        final token = data['token'] ?? data['access_token'];
        if (token != null) {
          await _apiClient.setToken(token);
        } else {
          return {
            'success': false,
            'message': 'Token tidak ditemukan dalam response server',
          };
        }

        // Simpan data user
        if (data['user'] != null) {
          final userData = data['user'];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(AppConstants.userIdKey, userData['id']?.toString() ?? '');
          await prefs.setString(AppConstants.userEmailKey, userData['email'] ?? '');
          await prefs.setString(AppConstants.userNameKey, userData['name'] ?? userData['nama'] ?? '');
        } else {
          return {
            'success': false,
            'message': 'Data user tidak ditemukan dalam response server',
          };
        }

        return {
          'success': true,
          'message': data['message'] ?? 'Login berhasil',
          'user': data['user'],
        };
      } else {
        // Handle error responses
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      // Handle network errors
      String errorMessage = 'Terjadi kesalahan saat menghubungi server';
      
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused') ||
          e.toString().contains('SocketException')) {
        errorMessage = 'Tidak dapat terhubung ke server backend. Pastikan:\n1. Backend sedang berjalan (port 8080)\n2. URL backend sudah benar di config';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Server tidak merespons. Periksa koneksi jaringan atau server mungkin sedang down.';
      } else {
        errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      }
      
      return {
        'success': false,
        'message': errorMessage,
      };
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String nim,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post('/auth/register', {
        'name': name,
        'nim': nim,
        'email': email,
        'password': password,
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': data['message'] ?? 'Registrasi berhasil',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Registrasi gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _apiClient.put('/auth/change-password', {
        'old_password': oldPassword,
        'new_password': newPassword,
      }, requireAuth: true);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'Password berhasil diubah',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal mengubah password',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Terjadi kesalahan: ${e.toString()}',
      };
    }
  }

  Future<UserModel?> getProfile() async {
    try {
      final response = await _apiClient.get('/auth/profile', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['user'] != null) {
          return UserModel.fromJson(data['user']);
        }
        return null;
      } else if (response.statusCode == 401) {
        // Token tidak valid atau expired
        print('Warning: Profile endpoint returned 401 - token may be invalid');
        // Jangan clear token di sini, biarkan user tetap login
        // Token akan di-refresh saat request berikutnya
        return null;
      } else {
        print('Warning: Profile endpoint returned status ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Jangan throw error, hanya return null
      print('Error in getProfile: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.post('/auth/logout', {}, requireAuth: true);
    } catch (e) {
      // Ignore error on logout
    } finally {
      await _apiClient.clearToken();
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _apiClient.getToken();
    return token != null && token.isNotEmpty;
  }
}

