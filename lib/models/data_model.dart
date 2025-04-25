class USerSignUpModel {
  final int id;
  final String userName;
  final String email;
  final String fullName;

  USerSignUpModel({required this.id, required this.userName, required this.email, required this.fullName});

  factory USerSignUpModel.fromJson(Map<String, dynamic> json) {
    return USerSignUpModel(
      id: json['id'],
     userName: json['username'], email: json['email'], fullName: json['full_name'],
    );
  }
   Map<String, dynamic> toJson(USerSignUpModel data) => {'id': data.id, 'username': data.userName, 'email': data.email, 'full_name': data.fullName};
}