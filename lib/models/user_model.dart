class LoginModel {
  final int id;
  final String username;
  final String token;
  final String? password;

  LoginModel({required this.id, required this.username, required this.token,this.password});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'],
      username: json['username'],
      token: json['token'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'token': token,
      'password': password
    };
  }
}