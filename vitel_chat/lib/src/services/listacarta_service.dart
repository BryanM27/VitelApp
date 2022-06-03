import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/global/json.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/response/prueba.dart';
//import 'package:vitel_chat/src/models/response/cartaporte_model.dart';

class CartaListService with ChangeNotifier {
  CartaModelResp _cartaResp = CartaModelResp(
      //idempresa: 0, clienteid: "", nombre: "", rfc: "",
      data: []);

  CartaModelResp get carta => _cartaResp;
  set carta(CartaModelResp value) {
    _cartaResp = value;
    notifyListeners();
  }

  Future<bool> getListCarta(String tokenResp) async {
    SharedPreference _sharedPreference = SharedPreference();
    // try{
    tokenResp =
        "aPjGSe-x7EVBI24_MXFdHYuUOzTT1OFZTyoreZrhk62E9dC1fFmklnZjgAA3E6xB16S2XXSXsj4OmQHYM1p5iVhI5bRQm5hrAd3HEprVVBcHMBdocg5JtzV_l-3bUgTaJ1Jf8JW0xQtSqKqawbjJnT59QuL6v9jq5CsCHiV2eWODHBqcN0Of6TlOfcwrUX6_HBHhhKdl_8tCJ4sikLLuf6mRtyd6EyYZTseDUSIitfBLXllfLH2CTBCCaywIqiayFvoGizeTTkm_Uwwf5Jet8tsZZvVSfos6Gd9bIIReTAzMlgGAsJQkSsZ6nCxrU-EnrrIegF9yH9-OA70OttvS1xX8Eh-KLbs1QBaQYpFBkD3ye9CDuF8OS5EAlYoXXpe3aqCJHemKY6hWszJV_c_equVZyVSaOHsLrauy9IbNwRj-w6bJKEdRWwoKZMLtTWFl9eEdi2mlfjIeev4n7kVIceNC0bgpQIt6Z5DisibwkRg46TC5JPfoXq4utQW7HdDmuTIM1EtR02gLIeZLQvEOWKLRtLfJviMDlCiI-2TyledhIqJX2b_U6tvr88cglgAf2biWU5p2hN6NzLfIzFyPtO85qDlX1GAbg3a309azkLrgbl_9p1EJLm8nmsuzZKet42DHR2XkY5mW5IUadl_kHBmDfQQOH2UrjfjycnmeaGdbVugm3JaKvDUT9-7Wh7iIzfvWccjwxdIpnC4spZcg8rQBbFZGk8EIN9LYSEFpssbzh1R5gkQG-9ZHWpO-PNNmMu5NEbH8QaF39rnHAuU31C2z8-4_gP2TNG5bMlAkSEEngvhlxdX4VFA4WBk4uPFxpHclj5ybrcrRnG1sX9zwerzwpn8xcosvICLntQ8_D1UsqC9_FvT4Ca-23mvViFjR";

    final response = await http.get(
        Uri.parse(
            '${url}API/CartaPorteMovil/GetCartasPorteOperador?NoLicencia=6519681'),
        //  body: "RFC:",
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $tokenResp',
        });

    final dec = response.body;
    final decodedData = cartaPruebaToJson(dec);
    decodedData.toString();

    int totalDatos = decodedData.data!.length;
    int? totalCarta = decodedData.data?[totalDatos - 1].cartaporte!.length;

    _sharedPreference.saveValueInt(totalDatos, conteo);
    _sharedPreference.saveValueInt(totalCarta!, TOTALCARTA);
    carta = decodedData;

    return true;
  }
}
