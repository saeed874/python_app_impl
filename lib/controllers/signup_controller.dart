
import 'package:flutter/material.dart';
import 'package:python_app/services/api_service.dart';
import 'package:python_app/views/home_view.dart';

class SignupController with ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signUp({
    required String email,
    required String password,
required String username,
required String fullName,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = await _apiService.signUp(
        email: email,
        password: password,
        username: username,
        fullName: fullName,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful: ${user.email}')),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $e')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}