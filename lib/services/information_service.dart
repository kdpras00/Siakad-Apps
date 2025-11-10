import 'dart:convert';
import '../models/information_model.dart';
import '../services/api_client.dart';

class InformationService {
  final ApiClient _apiClient = ApiClient();

  Future<List<InformationModel>> getAllInformation() async {
    try {
      final response = await _apiClient.get('/information', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['data'] != null) {
          return (data['data'] as List)
              .map((item) => InformationModel.fromJson(item))
              .toList();
        }
        if (data is List) {
          return data.map((item) => InformationModel.fromJson(item)).toList();
        }
        return [];
      } else {
        throw Exception('Gagal memuat data informasi: Status ${response.statusCode}');
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

  Future<InformationModel?> getInformationById(String id) async {
    try {
      final response = await _apiClient.get('/information/$id', requireAuth: true);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return InformationModel.fromJson(data['data'] ?? data);
      } else {
        throw Exception('Gagal memuat data informasi: Status ${response.statusCode}');
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

