import 'package:flutter/foundation.dart';
import '../models/kp_model.dart';
import '../services/kp_service.dart';

class KPProvider with ChangeNotifier {
  final KPService _kpService = KPService();
  
  KPModel? _kp;
  bool _isLoading = false;
  String? _errorMessage;

  KPModel? get kp => _kp;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadKerjaPraktek() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _kp = await _kpService.getKerjaPraktek();
      print('✅ KP Provider: Loaded KP data: ${_kp != null}');
      if (_kp == null) {
        print('⚠️ KP Provider: KP is null after loading');
      }
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('❌ KP Provider Error: $e');
      _errorMessage = 'Gagal memuat data Kerja Praktek: ${e.toString()}';
      _isLoading = false;
      _kp = null;
      notifyListeners();
    }
  }
}

