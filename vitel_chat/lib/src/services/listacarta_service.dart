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
        "4eY-gVDTCG9-p7BSYLRYfR2gtZrLgH0WXAH-q19RIW7oPV6z-NkTEAZkXQoMQ-XdT_lgI6Y87ibdaIykaWARTdt4Uc2PTNO-h8PElLhJd35d19J6lV7JGo6iAs-AQ0waM1mE0iISfCiwgvYuVIMtiY4Urf7NxlMgUwXkfrHZj6pBwzqwV5m6EEXfKgFiWGQ19YLH2ojr86SFj0JcIALA_Gjla7_GdRD6UWW5ZSQu-tcBM0uxZDFKl4YCPE6MsS1SZE_RYhBuCAbkkoAOobOO4TeHhBvf2-B-8u0VVVorIyIWI9BUasOj1PNfrf6Oiga83gEejEzPu1LL0EyilfnI1ew_or48jHB6lb6ppA2FHSFu_XfXKRtE82z2-Ml0Eu_kg4ZZt6xC8o7KEFKZOVETnDhLFiNIVvwv7_6iZZb9Upq2rM8ynfFDj4YJrPZbZVm1xCgawzyfch10JdpDIpmM4QD9i4CTV6Qbjz_ScUXmnT5GbPoxxp4SN6hgXUbmVFhwdGP_n2NF1zmkWrdLYQuh6rj315WyYeVDOYC7yHXzep5z9Uo6XDzHjWaEfhK5Y5nObaKfWufhZLRnGaHpKmR1rijnGuFIoxpb-8mFYvXhQA-xtaJ0aw1N1uculZZwsQgSNZasLd2Pj4-6SQIsheV-SYfVSl1WPFvFy009Gzo5qMQuBOG3nF2YvAgKDUJAnqW2qLhLvGM3W2ttcLzA-f8s5NfZMmgxdDIeDft1tqqozqJ45KI4zvAc0e3u9lW-xh1HY90TtoCTAVGgNE5ZZtVAVD1tyAtDafWH-PE10tzJvyB9IfQZGkZLWX0errU23Efk5hrIjVnzC0BIO0PyZhBZdyr4_wxsuhxlrkNGV2L4cG8CmiEXPfr0HRL71a_4xgpo";
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
