// ignore: file_names
import 'dart:convert';

String loginMovilModelToJson(LoginMovilModel data) =>
    json.encode(data.toJson());

class LoginMovilModel {
  final String? email;
  final String? password;
  final String? token;

  LoginMovilModel({this.email, this.password, this.token});

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "token": token,
      };
}
