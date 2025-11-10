import 'package:flutter/foundation.dart';
import '../models/information_model.dart';
import '../services/information_service.dart';

class InformationProvider with ChangeNotifier {
  final InformationService _informationService = InformationService();
  
  List<InformationModel> _informationList = [];
  InformationModel? _currentInformation;
  bool _isLoading = false;
  String? _errorMessage;

  List<InformationModel> get informationList => _informationList;
  InformationModel? get currentInformation => _currentInformation;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadAllInformation() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _informationList = await _informationService.getAllInformation();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat data informasi: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadInformationById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentInformation = await _informationService.getInformationById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Gagal memuat data informasi: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
    }
  }
}

