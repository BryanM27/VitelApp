import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:vitel_chat/src/models/response/loginresponse_model.dart';
import 'package:vitel_chat/src/services/token.dart';
import '../global/constants.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/authenticatemovil_model.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';

class AuthService with ChangeNotifier {
  final SharedPreference _sharedPreference = SharedPreference();

  Future<bool> login(LoginMovilModel login) async {
    //convertir modelo a Json
    json.encode(login);
    //Header requerido para enviar los valores
    const headersToken = {
      "Content-Type": "text/plain",
    };

    String params =
        'grant_type=password&username=${login.email}&password=${login.password}';

    debugPrint('Response params: $params');
    final response = await http.post(
      Uri.parse(url + "Token"),
      body: params,
      headers: headersToken,
    );
    final decodedData = responseAuthJson(response.body);
    // debugPrint('Response status: $params');
    // debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');
    debugPrint('response getToken: ${decodedData.accesstoken}');
    debugPrint('response statusGetToken: ${response.statusCode}');

    String getToken = decodedData.accesstoken.toString();
    if (response.statusCode != 200) {
      return false;
    }

    bool respToken = await getTokens(getToken);
    if (respToken == false) {
      return false;
    }
    _sharedPreference.saveValueString(decodedData.accesstoken!, TOKENMOVIL);
    _sharedPreference.saveValueBoolean(true, LOGGEDIN);

    notifyListeners();

    return true;
  }
}
