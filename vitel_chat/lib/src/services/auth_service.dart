import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
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
    final prefs = SharedPref.instance;
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
    prefs.firstLogin = true;

    bool a = true;
    if (a) {
      DateTime fecha1 = DateTime.now();
      DateTime fecha = fecha1.add(Duration(hours: 24));

      prefs.dateEndToken = fecha.toString();
      DateTime tok = DateTime.parse(prefs.dateEndToken!);
      if (tok.compareTo(DateTime.now()) > 0) {
        print("DT1 is before DT2");
      }
      // String fecha3 = DateFormat("dd-MM-yyyy hh:mm:ssZ")
      //     .format(DateTime.parse(DateTime.now().toString()));

      // DateTime fecha2 = DateTime.parse(fecha3);
      // DateTime fecha1 = DateTime.parse('2022-06-09 20:10:00Z');

      // DateTime horaTotal =
      //     fecha1.add(Duration(hours: fecha2.hour, minutes: fecha2.minute));
      debugPrint('horaTotal $fecha');
      // debugPrint('${horaTotal.hour}');
      // debugPrint('${horaTotal.minute}');
    }

    if (prefs.userEmail != '' && prefs.userEmail != login.email) {
      prefs.userEmail = login.email;
      prefs.validarLicencia = false;
      prefs.dataList = true;
      prefs.licenciaUser = 'NO HAY INFORMACION';
      prefs.tokenMovil = decodedData.accesstoken!;
      notifyListeners();
      return true;
    }
    prefs.tokenMovil = decodedData.accesstoken!;

    notifyListeners();

    return true;
  }
}
