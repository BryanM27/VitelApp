import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/services/listacarta_service.dart';
import 'package:vitel_chat/src/services/validatelicence_service.dart';

class LicenciaValidate extends StatefulWidget {
  LicenciaValidate({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LicenciaValidate createState() => _LicenciaValidate();
}

class _LicenciaValidate extends State<LicenciaValidate> {
  CartaListService? _cartaService;
  SharedPreference _sharedPreference = SharedPreference();
  TextEditingController licenciaController = new TextEditingController();

  final prefs = SharedPref.instance;
  final responseBool = new StreamController<bool>();

  @override
  void dispose() {
    super.dispose();
    responseBool.close();
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
    fontSize: 20,
  ));

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        height: 160.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          color: Colors.grey.shade300,
        ),
        child: StreamBuilder(
          stream: responseBool.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (prefs.validarLicencia == false) {
              return getFalse();
            }
            return getTrue();
            // return getTrue();
          },
        ),
      ),
    );
  }

  Widget getTrue() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Su número de licencia actual es ${prefs.licenciaUser}'),
          ElevatedButton(
            style: style,
            onPressed: () {
              // _getCartaporte(context);
              //reload();
              _showMyDialog();
            },
            child: const Text('Cambiar'),
          ),
        ],
      ),
    );
  }

  Widget getFalse() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
              'Para poder ver sus cartas porte asignadas, es necesario que ingrese su No. de licencia.'),
          TextField(
            controller: licenciaController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Número de licencia',
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              // prefs.validarLicencia = true;
              // responseBool.sink.add(true);
              _getCartaporte(context);
              // _showMyDialog();
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Advertencia'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¿Deseas cambiar el número de licencia?'),
                Text('Al aceptar eliminaras la licencia actual'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cambiar'),
              onPressed: () {
                prefs.dataList = false;
                prefs.validarLicencia = false;
                prefs.licenciaUser = '';

                responseBool.sink.add(false);
                // _sharedPreference.removeOne(LICENCIA);
                // _sharedPreference.saveValueBoolean(false, ISLICENCIA);
                // resp = false;
                Navigator.of(context).pop();
                //  Navigator.pushReplacementNamed(context, '/home');
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _aceptarRegistro() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¡Registro éxitoso!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('¡Licencia Valida!'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                prefs.dataList = true;
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
            ),
          ],
        );
      },
    );
  }

  void _getCartaporte(BuildContext context) async {
    if (licenciaController!.text != null && licenciaController!.text != '') {
      String token = await _sharedPreference.returnValueString(TOKENMOVIL);
      //String lic = await _sharedPreference.returnValueString(LICENCIA);
      bool resp = await getCartaporte(token, licenciaController!.text);
      if (resp == true) {
        prefs.validarLicencia = true;
        responseBool.sink.add(true);
        debugPrint("LICENCIA  VALIDA");
        _aceptarRegistro();
      } else {
        debugPrint("LICENCIA NO VALIDA");
      }
    }
  }
}
