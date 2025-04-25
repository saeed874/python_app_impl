import 'dart:developer';

import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/data_model.dart';
import '../utils/constants.dart';

class ApiService {
  late Dio _dio;
  
  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: Constants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      
    ));
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }
Future<USerSignUpModel> signUp({
  required String email,
  required String password,
  required String username,
  required String fullName
}) async {
  try {
    log("SIGNUP REQUEST: $email / $password / $username / $fullName");

    final response = await _dio.post(
      '/users',
      data: {
         "username": username,
        'email': email,
        'password': password,
        "full_name": fullName,
      },
      options: Options(
        contentType: Headers.jsonContentType, // Explicitly sending JSON
      ),
    );

    log("SIGNUP RESPONSE CODE: ${response.statusCode}");
    log("SIGNUP RESPONSE BODY: ${response.data}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return USerSignUpModel.fromJson(response.data);
    } else {
      throw Exception("Signup failed: ${response.statusCode}");
    }
  } catch (e) {
    log("SIGNUP ERROR: $e");
    if (e is DioException) {
      log("DIO ERROR BODY: ${e.response?.data}");
      log("DIO STATUS CODE: ${e.response?.statusCode}");
    }
    throw _handleError(e);
  }
}

  Future<LoginModel> login(String username, String password) async {
    try {
  log("SIGNUP 1111111111");

      final response = await _dio.post('/login',  data: FormData.fromMap({
    'username': username,
    'password': password,
  }),
  
  
   options: Options(
    contentType: Headers.formUrlEncodedContentType,
  ),
  );
      log("SIGNUP RESPONSE: ${response.statusCode}");
        if(response.statusCode == 200){

           log("SIGNUP RESPONSE: ${response.statusCode}");
          log("SIGNUP RESPONSE: ${response.data}");
 return LoginModel.fromJson(response.data);
        }else{
          
          throw Exception('Failed to login');
        }
     
   } catch (e) {
  log("LOGIN ERROR: $e");
  if (e is DioException) {
    log("DIO ERROR: ${e.response?.data}");
    log("DIO STATUS: ${e.response?.statusCode}");
  }
  throw _handleError(e);
}

  }

  // Fetch data
  Future<List<USerSignUpModel>> fetchData() async {
    try {
      final response = await _dio.get('/users');
      log("message: ${response.data}");

      if(response.statusCode != 200){
        throw Exception('Failed to fetch data');
      }else
      {
        return (response.data as List)
          .map((item) => USerSignUpModel.fromJson(item))
          .toList();
      }
    } catch (e) {
  log("LOGIN ERROR: $e");
  if (e is DioException) {
    log("DIO ERROR: ${e.response?.data}");
    log("DIO STATUS: ${e.response?.statusCode}");
  }
  throw _handleError(e);
}
  }

  // Error handling
  Exception _handleError(dynamic error) {
    if (error is DioException) {
      if (error.response != null) {
        return Exception('Server error: ${error.response?.statusCode}');
      }
      return Exception('Connection error: ${error.message}');
    }
    return Exception('Unknown error: $error');
  }









}