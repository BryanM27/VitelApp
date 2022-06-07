import 'package:flutter/cupertino.dart';
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<bool> getCartaporte(tokenResp, lic) async {
  final SharedPreference _sharedPreference = SharedPreference();
  // String tokens = await _sharedPreference.returnValueString(TOKENMOVIL);
  if (tokenResp != null && lic != null) {
    final response = await http.get(
        Uri.parse(
            '${url}API/CartaPorteMovil/GetCartasPorteOperador?NoLicencia=$lic'),
        //  body: "RFC:",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenResp',
        });

    final dec = response.statusCode;
    _sharedPreference.saveValueBoolean(true, ISLICENCIA);
    _sharedPreference.saveValueString(lic, LICENCIA);
    debugPrint('GetData  ${dec}');
    return true;
  }

  return false;
}
