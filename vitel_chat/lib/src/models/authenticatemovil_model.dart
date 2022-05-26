import 'dart:convert';

AuthenticateMovilModel authenticateMovilModelFromJson(String str) =>
    AuthenticateMovilModel.fromJson(json.decode(str));

class AuthenticateMovilModel {
  final String? email;
  final String? password;
  final int? roleid;
  final bool? accesstoken;

  AuthenticateMovilModel({
    this.email,
    this.password,
    this.roleid,
    this.accesstoken,
  });

  factory AuthenticateMovilModel.fromJson(Map<String, dynamic> json) =>
      new AuthenticateMovilModel(
        accesstoken: json['access_token'],
      );
}
