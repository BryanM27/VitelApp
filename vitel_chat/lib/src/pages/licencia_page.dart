import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:app_resources/src/Widgets/ToastCustom.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
import 'package:vitel_chat/src/pages/searchcartaporte_page.dart';
// import 'package:app_resources/src/models/LoginMovil_model.dart';
import 'package:vitel_chat/src/services/auth_service.dart';
import 'package:vitel_chat/src/services/listacarta_service.dart';
import 'package:vitel_chat/src/services/validatelicence_service.dart';
import 'package:vitel_chat/src/widgets/button_container.dart';
import 'package:vitel_chat/src/widgets/textfield_passwordcontainer.dart';
import 'package:vitel_chat/src/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

import '../global/constants.dart';

class Licencia extends StatefulWidget {
  @override
  _Licencia createState() => _Licencia();
}

class _Licencia extends State<Licencia> {
  int _page = 0;
  CartaListService? _cartaService;
  SharedPreference _sharedPreference = SharedPreference();
  TextEditingController licenciaController = new TextEditingController();

  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
          height: 160.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
            color: Colors.grey.shade300,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    'Para poder ver sus cartas porte asignadas, es necesario que ingrese su No. de licencia.'),
                TextField(
                  controller: licenciaController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Numero de licencia',
                  ),
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    _getCartaporte(context);
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      );

  void _getCartaporte(BuildContext context) async {
    final SharedPreference _sharedPreference = SharedPreference();
    if (licenciaController!.text != null) {
      String token = await _sharedPreference.returnValueString(TOKENMOVIL);
      //String lic = await _sharedPreference.returnValueString(LICENCIA);
      bool resp = await getCartaporte(token, licenciaController!.text);
      if (resp == true) {
        _sharedPreference.saveValueString(licenciaController!.text, LICENCIA);
        debugPrint("LICENCIA  VALIDA");
      } else {
        debugPrint("LICENCIA NO VALIDA");
      }
    }
  }
}
