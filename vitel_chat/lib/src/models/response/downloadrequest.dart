import 'dart:convert';

downloadResponseModel downloadModelFromJson(String str) =>
    downloadResponseModel.fromJson(json.decode(str));

class downloadResponseModel {
  final String? data;

  downloadResponseModel({
    this.data,
  });

  factory downloadResponseModel.fromJson(Map<String, dynamic> json) =>
      new downloadResponseModel(
        data: json['Data'],
      );
}
