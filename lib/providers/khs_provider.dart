import 'package:flutter/foundation.dart';
import '../models/khs_model.dart';
import '../services/khs_service.dart';

class KHSProvider with ChangeNotifier {
  final KHSService _khsService = KHSService();
  
  List<KHSModel> _khsList = [];
  KHSModel? _currentKHS;
  KHSRekapModel? _rekap;
  bool _isLoading = false;
  String? _errorMessage;

  List<KHSModel> get khsList => _khsList;
  KHSModel? get currentKHS => _currentKHS;
  KHSRekapModel? get rekap => _rekap;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadKHSRekap() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _rekap = await _khsService.getKHSRekap();
      print('✅ KHS Provider: Rekap loaded: ${_rekap != null}');
      
      if (_rekap != null) {
        _khsList = _rekap!.semesterList;
        print('✅ KHS Provider: Loaded ${_khsList.length} items from rekap');
      } else {
        print('⚠️ KHS Provider: Rekap is null, trying getAllKHS');
        _khsList = await _khsService.getAllKHS();
        print('✅ KHS Provider: Loaded ${_khsList.length} items from getAllKHS');
      }
      
      if (_khsList.isEmpty) {
        print('⚠️ KHS Provider: List is empty after loading');
      }
      
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('❌ KHS Provider Error: $e');
      _errorMessage = 'Gagal memuat data KHS: ${e.toString()}';
      _isLoading = false;
      _khsList = [];
      _rekap = null;
      notifyListeners();
    }
  }

  Future<void> loadKHSBySemester(String semester) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentKHS = await _khsService.getKHSBySemester(semester);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat data KHS: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}

