import 'package:flutter/foundation.dart';
import '../models/skripsi_model.dart';
import '../services/skripsi_service.dart';

class SkripsiProvider with ChangeNotifier {
  final SkripsiService _skripsiService = SkripsiService();
  
  SkripsiModel? _skripsi;
  bool _isLoading = false;
  String? _errorMessage;

  SkripsiModel? get skripsi => _skripsi;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadSkripsi() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _skripsi = await _skripsiService.getSkripsi();
      print('✅ Skripsi Provider: Loaded Skripsi data: ${_skripsi != null}');
      if (_skripsi == null) {
        print('⚠️ Skripsi Provider: Skripsi is null after loading');
      }
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('❌ Skripsi Provider Error: $e');
      _errorMessage = 'Gagal memuat data Skripsi: ${e.toString()}';
      _isLoading = false;
      _skripsi = null;
      notifyListeners();
    }
  }
}

