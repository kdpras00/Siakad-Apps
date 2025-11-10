import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isAuthenticated = await _authService.isLoggedIn();
    if (_isAuthenticated) {
      // Load profile tapi jangan gagal jika error (optional)
      try {
        await loadProfile();
      } catch (e) {
        // Silent fail - user sudah login, profile bisa dimuat nanti
        print('Warning: Failed to load profile on init: $e');
      }
    }
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.login(username, password);
      
      if (result['success'] == true) {
        _isAuthenticated = true;
        if (result['user'] != null) {
          _user = UserModel.fromJson(result['user']);
        } else {
          await loadProfile();
        }
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String nim,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.register(
        name: name,
        nim: nim,
        email: email,
        password: password,
      );

      _isLoading = false;
      
      if (result['success'] == true) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadProfile() async {
    try {
      _user = await _authService.getProfile();
      if (_user == null) {
        // Jika profile null, tetap set authenticated = true jika token ada
        // Karena mungkin user sudah login tapi profile endpoint error
        print('Warning: Profile returned null, but user is authenticated');
      }
      notifyListeners();
    } catch (e) {
      // Jangan set error message yang terlalu agresif
      // Karena ini mungkin hanya network error sementara
      print('Error loading profile: $e');
      // Tetap set user jika ada, jangan clear authentication
      if (_user == null) {
        _errorMessage = null; // Clear error, allow user to continue
      }
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _authService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      _isLoading = false;
      
      if (result['success'] == true) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    _isAuthenticated = false;
    _errorMessage = null;
    notifyListeners();
  }
}

