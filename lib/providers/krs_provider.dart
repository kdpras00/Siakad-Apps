import 'package:flutter/foundation.dart';
import '../models/krs_model.dart';
import '../services/krs_service.dart';

class KRSProvider with ChangeNotifier {
  final KRSService _krsService = KRSService();
  
  List<KRSModel> _krsList = [];
  KRSModel? _currentKRS;
  bool _isLoading = false;
  String? _errorMessage;

  List<KRSModel> get krsList => _krsList;
  KRSModel? get currentKRS => _currentKRS;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAllKRS() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _krsList = await _krsService.getAllKRS();
      print('✅ KRS Provider: Loaded ${_krsList.length} items');
      if (_krsList.isEmpty) {
        print('⚠️ KRS Provider: List is empty after loading');
      }
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('❌ KRS Provider Error: $e');
      _errorMessage = 'Gagal memuat data KRS: ${e.toString()}';
      _isLoading = false;
      _krsList = [];
      notifyListeners();
    }
  }

  Future<void> loadKRSBySemester(String semester) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentKRS = await _krsService.getKRSBySemester(semester);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat data KRS: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}

