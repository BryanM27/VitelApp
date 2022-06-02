import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/models/response/cartaporte_model.dart';

class CartaListService with ChangeNotifier {
  CartaModelResp _cartaResp = CartaModelResp(
      idempresa: 0, clienteid: "", nombre: "", rfc: "", cartaporte: []);

  CartaModelResp get carta => _cartaResp;
  set carta(CartaModelResp value) {
    _cartaResp = value;
    notifyListeners();
  }

  Future<bool> getListCarta(String tokenResp) async {
    // try{
    tokenResp =
        "iPwOXbclBjLJGLjD5MmexRkEHwFbJzzbNaLpw3hu-YmAsVSM4H8Ea7dI-Rgv4W1DjyXkkD9t52mivXx4NBDQimeEC309c6LURTeOtvvQ_GnwICKEQKuSxjRDyStO0Jsa8sXTcBD1phGQ70-hnQ9tkuE38gRZ51IRe0Sa3Y_-wDwmH9xehKTvJC7x7fbQVQvbC7cQq_DGONMxrpc1_4UDliVkp3qwKAXaP7SSGqXDtXX0dJKfZ1qF37j8u9qGRXH3L4ChjXO9J0l0y3tGSUWLHkLwV9tHHjI0LZOHxQ5hSZfoQw5LOj9iAcqLdrTozaE-5jqB-jiRdqQCy8oZuJcjPFMRf9raL7cj6GqdPkpPd-JKfyMYA-J1Ubjs8Gwi5J1z9GvxnE1HzbOCa64M1bYhH7r1DrJjzIeVW0wKhx1dceIB9hqUC4cGjLYfmRMUUFcTUmk5FLAbAfP93_v1QKMv0AfAiwdC-OF-w1OYy_hDa5dunnFhfyo9c0CVv_vTEyPjBZFLP1cyirgo8rp68RDGcpeJNqJICnlLhmKcno5-BDxuOov_-BO7iNYa6Voi8pMgx4XgPzR3TCAwFoS5KIk1c67BHnyqxh-wdRMsSvg8VCTZ0WOMYoTPXsxrJBjX9sWaHwK8gIec2nbyih7Vf3WPepB1ocQ3OQl5LocWXmxwaz-mkMWyIQz0OhSt1_EKdN6rd2PfXJ-yzTNMk7qvUZj4vFEuzJNx8MJp-n4BihPuoj7UyVCn3kB6XlHkuwouJt04OY0a4W1kiOv5woRN6KPjZNJx5s4ofWqzt4uNYfl2Kkv1PaUp71ZafBFuKtSj8ITF4NTyI3cTGoESsXn0mskRxhVLJNY1neTvExPEQrGicKOevW6Ugn6mgisUwan8sIIq";

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
    var tagObjsJson = jsonDecode(dec)['Data'];
    final decodedData = cartaResponseToJson(tagObjsJson, 0);
    decodedData.toString();
    debugPrint('prueba de objetos ${decodedData.idempresa}');
    carta = decodedData;

    return true;
    // }
    // catch( e ) {
    //   return false;
    // }
  }
}
