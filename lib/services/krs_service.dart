import 'dart:convert';
import '../models/krs_model.dart';
import '../services/api_client.dart';

class KRSService {
  final ApiClient _apiClient = ApiClient();

  // Karena hanya ada tabel users dan information, kita akan generate data KRS dari data user
  // atau backend bisa return data yang sudah diformat
  Future<List<KRSModel>> getAllKRS() async {
    try {
      final response = await _apiClient.get('/krs', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('📦 KRS Response data: $data');
        
        if (data['data'] != null) {
          final dataList = data['data'];
          if (dataList is List) {
            if (dataList.isEmpty) {
              print('⚠️ KRS: Data kosong');
              return [];
            }
            return (dataList)
                .map((item) => KRSModel.fromJson(item))
                .toList();
          }
        }
        // Jika data langsung array
        if (data is List) {
          return data.map((item) => KRSModel.fromJson(item)).toList();
        }
        print('⚠️ KRS: Tidak ada data, return empty list');
        return [];
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Silakan login ulang');
      } else {
        final errorBody = response.body;
        print('❌ KRS Error Response: $errorBody');
        throw Exception('Gagal memuat data KRS: Status ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw error agar provider bisa menangkap dan menampilkan pesan error
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

  Future<KRSModel?> getKRSById(String id) async {
    try {
      final response = await _apiClient.get('/krs/$id', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return KRSModel.fromJson(data['data'] ?? data);
      } else {
        throw Exception('Gagal memuat data KRS: Status ${response.statusCode}');
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

  Future<KRSModel?> getKRSBySemester(String semester) async {
    try {
      final response = await _apiClient.get('/krs/semester/$semester', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return KRSModel.fromJson(data['data'] ?? data);
      } else {
        throw Exception('Gagal memuat data KRS: Status ${response.statusCode}');
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
