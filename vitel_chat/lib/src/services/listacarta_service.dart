import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/global/json.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/response/cartaporterequest_model.dart';
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

  Future<bool> getListCarta(String tokenResp, String lic) async {
    SharedPreference _sharedPreference = SharedPreference();
    final prefs = SharedPref.instance;
    // String lic = prefs.licenciaUser!;
    // String tokenResp = prefs.tokenMovil!;
    // try{
    // tokenResp =
    //     "4K6c54iO1ZOA8GTWfUyjMlVybHSE3eXowwAzxoc4ANFlGFNxmx0uaCMvPdzmkfwOzBl-1khq4cIulZLI55VMxkPbBa3kco2NOfWzF0VDJUWN8zw9wfG4XTmpfynrNScowQiKqzp2IvDUksI28i4d9NCV-VnDLzWHIb9DyNhm9Aau_GtHo5NRaOCRTXmUWtkDEJvCRfHlvY-k7cw6QhnZLFAjIqk7Wh5MI2GoLdgyOW3ykNYA69y6TUMgVskaUs5cPC35Kf1kmBJVkOOz__P2vfHgZWAgXESaIzYsQJe3MJiNrym6wnFVWEDUw4wJHhYpIwZtFDmU76XTZ6ETdXH3xnFnckIxYIZOj8rtKNKVuXmR5lwUOMbhe4PVHPKk40IGEw3F2XzpzgIF-QV0q3ldhjLMOUroBzwjr9vW6jJQCuX1ab6e01vhgb-EfM6O3Af1jMtD-W9KMHfCwzbt2GjQ7YnnHni6oG7wHufSOpsSvN8782WunCawjhHeMfWjkqSHbkBqfndoXDne6_9pMHj3nONrvpfzBmD_SYLbwpx9cvBTIAIG4KYQlts5LSy9rYGCazLzB2ZGPZZXVz2nVdoSvN0ZeIFRTzqh19sUVtv8TyqFUH10b9aUTa4oXmGQvu14gYKI1q9-5KdMxmzMij61zlORTSXbJuEGvvVEzBieVWCYM7XJcmpauRGPmxxAt4vQn8zKDxoqpMatEED7dQ8m3DBuGpKYsDrPP2XFxKX-z809isAl7tiDjj81oe_A_y6ZEfoe8ZoXgqfukxhuhfON_TRo0NfCB5U68wKwQaLSHI59ZbM-EZpyZMQqWJ9nL6bJFjTa9UyNyihx_lBQtxTDYmNJgQNTsAIi-uidIi9Xyw0cmueHUpJdp-5hHATYytvu";
    if (await tokenResp != null &&
        await lic != null &&
        await lic != "NO HAY INFORMACION") {
      final response = await http.get(
          Uri.parse(
              '${url}API/CartaPorteMovil/GetCartasPorteOperador?NoLicencia=$lic'),
          //  body: "RFC:",
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tokenResp',
          });

      final dec = response.body;
      final decodedData = cartaPruebaToJson(dec);
      decodedData.toString();
      debugPrint("estatus guardado ${response.statusCode}");
      int? totalEmpresas = decodedData.data!.length;
      int? totalCartaportes =
          decodedData.data?[totalEmpresas - 1].cartaporte!.length;

      prefs.totalEmpresas = totalEmpresas;
      prefs.totalCartaPortes = totalCartaportes;

      _sharedPreference.saveValueInt(response.statusCode, ESTATUS);
      _sharedPreference.saveValueInt(totalEmpresas, conteo);
      _sharedPreference.saveValueInt(totalCartaportes!, TOTALCARTA);
      prefs.dataList == true;
      //_sharedPreference.saveValueBoolean(true, ISLICENCIA);
      carta = decodedData;
      prefs.validarLicencia = true;
      prefs.dataList = false;
      return true;
    }
    prefs.validarLicencia = false;
    return false;
  }
}
