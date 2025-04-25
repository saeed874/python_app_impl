import 'dart:developer';

import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthController extends ChangeNotifier {
  final ApiService _apiService;
  final StorageService _storageService;
  
  LoginModel? _currentUser;
  bool _isLoading = false;
  String? _error;
  
  AuthController(this._apiService, this._storageService) {
    _loadUserFromStorage();
  }
  
  LoginModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;
  
  void _loadUserFromStorage() {
    _currentUser = _storageService.getUser();
    if (_currentUser != null) {
      _apiService.setAuthToken(_currentUser!.token);
    }
    notifyListeners();
  }
  
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _currentUser = await _apiService.login(username, password);

      log("SIGNUP RESPONSE: ${_currentUser?.toJson()}");
      await _storageService.saveUser(_currentUser!);
      _apiService.setAuthToken(_currentUser!.token);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  Future<void> logout() async {
    await _storageService.logout();
    _currentUser = null;
    notifyListeners();
  }
}