import 'dart:convert';
import '../models/khs_model.dart';
import '../services/api_client.dart';

class KHSService {
  final ApiClient _apiClient = ApiClient();

  Future<KHSRekapModel?> getKHSRekap() async {
    try {
      final response = await _apiClient.get('/khs/rekap', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('📦 KHS Rekap Response data: $data');
        
        if (data['data'] == null || (data['data'] is Map && (data['data'] as Map).isEmpty)) {
          print('⚠️ KHS: Data kosong');
          return null;
        }
        
        return KHSRekapModel.fromJson(data['data'] ?? data);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Silakan login ulang');
      } else {
        final errorBody = response.body;
        print('❌ KHS Error Response: $errorBody');
        throw Exception('Gagal memuat data KHS: Status ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused') ||
          e.toString().contains('SocketException')) {
        throw Exception('Tidak dapat terhubung ke server backend. Pastikan backend sedang berjalan.');
      } else if (e.toString().contains('timeout')) {
        throw Exception('Server tidak merespons. Periksa koneksi jaringan.');
      }
      rethrow;
    }
  }

  Future<List<KHSModel>> getAllKHS() async {
    try {
      final response = await _apiClient.get('/khs', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          return (data['data'] as List)
              .map((item) => KHSModel.fromJson(item))
              .toList();
        }
        if (data is List) {
          return data.map((item) => KHSModel.fromJson(item)).toList();
        }
        return [];
      } else {
        throw Exception('Gagal memuat data KHS: Status ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused') ||
          e.toString().contains('SocketException')) {
        throw Exception('Tidak dapat terhubung ke server backend. Pastikan backend sedang berjalan.');
      } else if (e.toString().contains('timeout')) {
        throw Exception('Server tidak merespons. Periksa koneksi jaringan.');
      }
      rethrow;
    }
  }

  Future<KHSModel?> getKHSBySemester(String semester) async {
    try {
      final response = await _apiClient.get('/khs/semester/$semester', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return KHSModel.fromJson(data['data'] ?? data);
      } else {
        throw Exception('Gagal memuat data KHS: Status ${response.statusCode}');
      }
    } catch (e) {
      if (e.toString().contains('Failed host lookup') || 
          e.toString().contains('Connection refused') ||
          e.toString().contains('SocketException')) {
        throw Exception('Tidak dapat terhubung ke server backend.');
      }
      rethrow;
    }
  }
}

