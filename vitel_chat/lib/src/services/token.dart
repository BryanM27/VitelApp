import 'package:flutter/cupertino.dart';
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import '../global/constants.dart';

Future<bool> getTokens(String tokens) async {
  final SharedPreference _sharedPreference = SharedPreference();
  // String tokens = await _sharedPreference.returnValueString(TOKENMOVIL);

  final response =
      await http.get(Uri.parse(url + 'api/CartaPorteMovil/GetUserRole'),
          //  body: "RFC:",
          headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokens',
      });

  debugPrint('Response status getRol: ${response.statusCode}');
  debugPrint('Response status getRol: ${response.body}');
  debugPrint('Response body getRol: $tokens');
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
  // _sharedPreference.saveValueBoolean(true, LOGGEDIN);

  // notifyListeners();
  return true;
}
