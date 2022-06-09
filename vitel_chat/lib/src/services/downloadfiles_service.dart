import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/models/response/downloadrequest.dart';

Future<bool> downloadPDF(
    String? idclient, int? idcartaporte, int? idempresa, String? tokens) async {
  final prefs = SharedPref.instance;
  final response = await http.get(
      Uri.parse(url +
          'api/CartaPorteMovil/GetPDFCartaPorte?ClientID=$idclient&IDCartaPorte=$idcartaporte&IDEmpresa=$idempresa'),
      //  body: "RFC:",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokens',
      });
  final decodedData = downloadModelFromJson(response.body);
  debugPrint('BASE 64 ${decodedData.data}');
  Future<String> route = getPath();
  Future<String> path = _createFileFromString(decodedData.data, route, ".pdf");

  debugPrint('BASE 64 $path');
  //debugPrint('BASE 64 $idclient, $idcartaporte, $idempresa, $tokens');

  return true;
}

Future<bool> downloadXML(
    String? idclient, int? idcartaporte, int? idempresa, String? tokens) async {
  final prefs = SharedPref.instance;
  final response = await http.get(
      Uri.parse(url +
          'api/CartaPorteMovil/GetXMLCartaPorte?ClientID=$idclient&IDCartaPorte=$idcartaporte&IDEmpresa=$idempresa'),
      //  body: "RFC:",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokens',
      });
  final decodedData = downloadModelFromJson(response.body);
  debugPrint('BASE 64 ${decodedData.data}');
  Future<String> route = getPath();
  Future<String> path = _createFileFromString(decodedData.data, route, ".xml");

  debugPrint('BASE 64 $path');
  //debugPrint('BASE 64 $idclient, $idcartaporte, $idempresa, $tokens');

  return true;
}

Future<String> _createFileFromString(
    String? fileName, Future<String> route, String extension) async {
  final encodedStr = fileName;
  Uint8List bytes = base64.decode(encodedStr!);
  String dir = await route;
  File file = File(
      "$dir/" + DateTime.now().millisecondsSinceEpoch.toString() + extension);
  await file.writeAsBytes(bytes);
  await file.create(recursive: true);
  // Uint8List bytesfile = await file.readAsBytes();
  // await file.writeAsBytes(bytesfile);
  return file.path;
}

Future<String> getPath() async {
  var path = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS);
  return path; // /storage/emulated/0/Pictures
}
