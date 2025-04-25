import 'package:flutter/material.dart';
import '../models/data_model.dart';
import '../services/api_service.dart';

class DataController extends ChangeNotifier {
  final ApiService _apiService;
  
  List<USerSignUpModel> _items = [];
  bool _isLoading = false;
  String? _error;
  
  DataController(this._apiService);
  
  List<USerSignUpModel> get items => _items;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  Future<void> fetchData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    
    try {
      _items = await _apiService.fetchData();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}