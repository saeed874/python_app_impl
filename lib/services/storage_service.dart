import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class StorageService {
  late SharedPreferences _prefs;
  
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save user data
  Future<void> saveUser(LoginModel user) async {
    await _prefs.setString('user', jsonEncode(user.toJson()));
  }

  // Get user data
  LoginModel? getUser() {
    final userData = _prefs.getString('user');
    if (userData != null) {
      return LoginModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _prefs.containsKey('user');
  }

  // Log out user
  Future<void> logout() async {
    await _prefs.remove('user');
  }
}