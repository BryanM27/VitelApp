import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:app_resources/src/Widgets/ToastCustom.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/services/listacarta_service.dart';
import 'package:vitel_chat/src/services/validatelicence_service.dart';

import '../global/constants.dart';

class Licencia extends StatefulWidget {
  @override
  _Licencia createState() => _Licencia();
}

class _Licencia extends State<Licencia> {
  CartaListService? _cartaService;
  SharedPreference _sharedPreference = SharedPreference();
  bool? resp;

  String licnum = "";
  TextEditingController licenciaController = new TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _onLoadingLicencia();
  }

  void _onRefreshLicencia() async {
    await Future.delayed(Duration(milliseconds: 1000));
    initValue();
    _refreshController.refreshCompleted();
  }

  void initValue() async {
    licnum = await _sharedPreference.returnValueString(LICENCIA);
    resp = await _sharedPreference.returnValueBoolean(ISLICENCIA);
    if (resp == null) {
      resp == false;
    }
  }

  void _onLoadingLicencia() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    initValue();
    _refreshController.loadComplete();
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
    fontSize: 20,
  ));
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
        child: resp != null
            ? getResp(resp!)
            : Center(child: CircularProgressIndicator()),
      ));

  void _getCartaporte(BuildContext context) async {
    if (licenciaController!.text != null) {
      String token = await _sharedPreference.returnValueString(TOKENMOVIL);
      //String lic = await _sharedPreference.returnValueString(LICENCIA);
      bool resp = await getCartaporte(token, licenciaController!.text);
      if (resp == true) {
        _sharedPreference.saveValueString(licenciaController!.text, LICENCIA);
        debugPrint("LICENCIAs  VALIDA");
        _aceptarRegistro();
        resp = true;
      } else {
        debugPrint("LICENCIA NO VALIDA");
      }
    }
  }

  Widget getResp(bool? res) {
    if (resp! == true) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Su número de licencia actual es $licnum'),
            ElevatedButton(
              style: style,
              onPressed: () {
                // _getCartaporte(context);

                _showMyDialog();
              },
              child: const Text('Cambiar'),
            ),
          ],
        ),
      );
    }
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
                _sharedPreference.removeOne(LICENCIA);
                _sharedPreference.saveValueBoolean(false, ISLICENCIA);
                resp = false;
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home');
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
                _sharedPreference.removeOne(LICENCIA);
                _sharedPreference.saveValueBoolean(false, ISLICENCIA);
                resp = false;
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/home');
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
}
