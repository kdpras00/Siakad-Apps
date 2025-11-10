import 'dart:convert';
import '../models/kp_model.dart';
import '../services/api_client.dart';

class KPService {
  final ApiClient _apiClient = ApiClient();

  Future<KPModel?> getKerjaPraktek() async {
    try {
      final response = await _apiClient.get('/kerja-praktek', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('📦 KP Response data: $data');
        
        if (data['data'] != null && data['data'] is Map) {
          return KPModel.fromJson(data['data']);
        }
        print('⚠️ KP: Data kosong atau null');
        return null;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized - Silakan login ulang');
      } else {
        final errorBody = response.body;
        print('❌ KP Error Response: $errorBody');
        throw Exception('Gagal memuat data Kerja Praktek: Status ${response.statusCode}');
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
}

