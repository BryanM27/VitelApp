import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/models/operador_model.dart';
import '../global/constants.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/AuthenticateMovil_model.dart';

class AuthService with ChangeNotifier {
  final SharedPreference _sharedPreference = SharedPreference();

  Future<bool> login(OperadorModel operador) async {
    // String jsonString = operadormodelToJson(operador);
    // String paramName = 'param'; // give the post param a name
    // String formBody = paramName + '=' + Uri.encodeQueryComponent(jsonString);
    // List<int> bodyBytes = utf8.encode(formBody);
    // HttpClientRequest request =        await _httpClient.post(_host, _port, '/a/b/c');
    //debugPrint('body: $bodyBytes');
    const headersToken = {
      "Content-Type": "text/plain",
    };

    const params =
        "grant_type=password&username=bryan.mendez@vitel.mx&password=bry@n22%";

    debugPrint('Response body: ${json.encode(operador)}');
    final response = await http.post(
      Uri.parse(url + "Token"),
      body: params,
      headers: headersToken,
    );

    debugPrint('Response status: $operadormodelToJson(operador)');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    // final decodedData = authenticateMovilModelFromJson(resp.body);

    if (response.statusCode != 200) {
      return false;
    }
    // debugPrint('debug: $decodedData.userid');
    // print(decodedData.resourcedataid);
    // print(decodedData.roleid);
    // print(decodedData.status);
    // _sharedPreference.saveValueInt(decodedData.userid!, USERID);
    // _sharedPreference.saveValueInt(decodedData.resourcedataid!, RESOURCEDATAID);
    // _sharedPreference.saveValueInt(decodedData.roleid!, ROLEID);
    // _sharedPreference.saveValueBoolean(decodedData.status!, USERSTATUS);
    _sharedPreference.saveValueBoolean(true, LOGGEDIN);

    notifyListeners();
    return true;
  }
}
