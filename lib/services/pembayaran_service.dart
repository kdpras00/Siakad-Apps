import 'dart:convert';
import '../models/pembayaran_model.dart';
import '../services/api_client.dart';

class PembayaranService {
  final ApiClient _apiClient = ApiClient();

  Future<List<PembayaranModel>> getAllPembayaran() async {
    try {
      final response = await _apiClient.get('/pembayaran', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('📦 Pembayaran Response data: $data');
        
        if (data['data'] != null) {
          final dataList = data['data'];
          if (dataList is List) {
            if (dataList.isEmpty) {
              print('⚠️ Pembayaran: Data kosong');
              return [];
            }
            return (dataList)
                .map((item) => PembayaranModel.fromJson(item))
                .toList();
          }
        }
        if (data is List) {
          return data.map((item) => PembayaranModel.fromJson(item)).toList();
        }
        print('⚠️ Pembayaran: Tidak ada data, return empty list');
        return [];
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Silakan login ulang');
      } else {
        final errorBody = response.body;
        print('❌ Pembayaran Error Response: $errorBody');
        throw Exception('Gagal memuat data pembayaran: Status ${response.statusCode}');
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

  Future<PembayaranModel?> getPembayaranBySemester(String semester) async {
    try {
      final response = await _apiClient.get('/pembayaran/semester/$semester', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return PembayaranModel.fromJson(data['data'] ?? data);
      } else {
        throw Exception('Gagal memuat data pembayaran: Status ${response.statusCode}');
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

