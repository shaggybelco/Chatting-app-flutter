import 'package:frontend/Models/user.model.dart';

class LoginModel {
  String? cellphone;
  String? password;

  LoginModel({this.cellphone, this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "cellphone": cellphone!.trim(),
      "password": password!.trim()
    };

    return map;
  }
}

class AuthResponseModel {
  final String? message;
  final String? error;
  final String? token;
  final UserModel? user;

  AuthResponseModel({
    this.message,
    this.error,
    this.token,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String,dynamic> json) {
    
    return AuthResponseModel(
      message: json["message"] ?? "",
      token: json["token"] ?? "",
      user: UserModel.fromJson(json["user"]),
      error: json["error"] ?? "",
    );
  }
}
