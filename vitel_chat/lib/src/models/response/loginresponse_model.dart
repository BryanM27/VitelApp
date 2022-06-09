import 'dart:convert';

import 'package:intl/intl.dart';

ResponseAuth responseAuthJson(String str) =>
    ResponseAuth.fromJson(json.decode(str));

class ResponseAuth {
  final String? accesstoken;

  ResponseAuth({
    this.accesstoken,
  });

  factory ResponseAuth.fromJson(Map<String, dynamic> json) => new ResponseAuth(
        accesstoken: json['access_token'],
      );
}
