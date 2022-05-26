import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:vitel_chat/src/models/response/cartaporte_model.dart';
import 'package:vitel_chat/src/models/response/loginresponse_model.dart';
import 'package:vitel_chat/src/services/token.dart';
import '../global/constants.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/authenticatemovil_model.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';

Future<bool> getCartaporte() async {
  final SharedPreference _sharedPreference = SharedPreference();
  // String tokens = await _sharedPreference.returnValueString(TOKENMOVIL);
  String tokens =
      "HgGqwb3x-VjTaqZopBuOlwoYp99oHG8uCapofzOVSavzgDTrdjTJNQYmLnRq4pycRmhlZ-Hg6GwLrU1RfWURHi57nArlgAp9viy9HvygLrotawa5Hn4b7aBRZjF44yWTyZnbTBdEwB27c-X37aXtKolSwwPYBpL6Jwxvrn-3lSYzMdDZXSG5iJ2u4-JKcywpXYiT8LDEfiZN101bTxIgS6E2Aa1k8BjMVJ2IBILLV2qnCLHmeLv_QXc_MUKidzTiouz2iEkVMpgK9oSuUIVh8ZZ-qSBNVKCwTRznG6wPsA6tOxHA69AVb4KcB5och1Mq3EmfgUpF80bifAc8C8-GS9qSNor6pfSRXySPoucyHK2kYe6I9eN267m-8i3pZZxfHuXwOJ1V5JMdkL3oFDWwfTnORVAWno3KlbDF8ljTiieVqpiXR9rbVhcvYyvN5Iv_UWyrqaH5JgmhqZJxneKrJi429YIpvTvNKx90T8e1HUPfA4wHD1_nMUhFtmtFtTu2oC8sg6ME15NDeicbXqum932vjbJBZpEKg9A5ttj0_cYbF92bBHPfwcfPFOGrrZd9ef986Zi4g2dz5KRNfgA2r3i2tSc1dSlbGrM7asupFbNERikvNGsv778_LtjtECqfabx4dT-ebhoI6danC6qW37RWza1vwYJKibPfFavRJmEK4NwFZ71J4Ky0LCfQhq2jYFiZO1AGXyJgOaEB7KqzJ53IoKtHXcij5h521K8SybbbpypAh7L33VGEp68hBWcgJIPaAZS7Ru2Lm_GueAM2LQGzZq09nmW6qtePiwyVQFf6a6e7kwx6iUDBu0o50nACCT2Xim3gaX_OuJvR6WnalIE9GdGvxUGHX98q2B802k6l7i6S1-SRyJ_AwvkRd9L2";

  final response = await http.get(
      Uri.parse(url +
          'API/CartaPorteMovil/GetCartasPorteOperador?NoLicencia=6519681'),
      //  body: "RFC:",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokens',
      });

  // debugPrint('Response status getRol: ${response.statusCode}');
  // debugPrint('Response status getRol: ${response.body}');
  // debugPrint('Response body getRol: $tokens');

  String arrayObjsText = response.body.toString();
  var tagObjsJson = jsonDecode(arrayObjsText)['Data'] as List;
  List<Tag> tagObjs =
      tagObjsJson.map((tagJson) => Tag.fromJson(tagJson)).toList();
  debugPrint('prueba de objetos ${tagObjs}');

  if (response.statusCode != 200) {
    return false;
  }
  //debugPrint('debug Operador: ${decodedData.idempresa}');
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

class Tag {
  int idempresa;
  String clientid;
  Tag(this.idempresa, this.clientid);
  factory Tag.fromJson(dynamic json) {
    return Tag(json['IDEmpresa'] as int, json['ClientID'] as String);
  }
}
