import 'package:flutter/foundation.dart';
import '../models/pembayaran_model.dart';
import '../services/pembayaran_service.dart';

class PembayaranProvider with ChangeNotifier {
  final PembayaranService _pembayaranService = PembayaranService();
  
  List<PembayaranModel> _pembayaranList = [];
  PembayaranModel? _currentPembayaran;
  bool _isLoading = false;
  String? _errorMessage;

  List<PembayaranModel> get pembayaranList => _pembayaranList;
  PembayaranModel? get currentPembayaran => _currentPembayaran;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAllPembayaran() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _pembayaranList = await _pembayaranService.getAllPembayaran();
      print('✅ Pembayaran Provider: Loaded ${_pembayaranList.length} items');
      if (_pembayaranList.isEmpty) {
        print('⚠️ Pembayaran Provider: List is empty after loading');
      }
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      print('❌ Pembayaran Provider Error: $e');
      _errorMessage = 'Gagal memuat data pembayaran: ${e.toString()}';
      _isLoading = false;
      _pembayaranList = [];
      notifyListeners();
    }
  }

  Future<void> loadPembayaranBySemester(String semester) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentPembayaran = await _pembayaranService.getPembayaranBySemester(semester);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat data pembayaran: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}

