// ignore_for_file: deprecated_member_use

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vitel_chat/src/app.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/pages/licenciavalidate_page.dart';
import 'package:vitel_chat/src/pages/listcartaportesbussines_page.dart';
import 'package:vitel_chat/src/pages/searchcartaporte_page.dart';
import 'package:vitel_chat/src/services/listacarta_service.dart';

import '../global/constants.dart';
import '../global/size_config.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;
  CartaListService? _cartaService;

  SharedPreference _sharedPreference = SharedPreference();
  TextEditingController? licenciaController;
  final prefs = SharedPref.instance;

  GlobalKey<ScaffoldState> mScaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey bottomNavigationBar = GlobalKey();

  Widget _callPage(int actuallyPage) {
    if (prefs.licenciaUser != '' && prefs.firstLogin == true) {
      actuallyPage = 1;
      prefs.firstLogin = false;
      _page = 1;
    }
    switch (actuallyPage) {
      case 0:
        return LicenciaValidate();
      // case 1:
      //   return RegisterLicense();
      case 1:
        return ListCartaPorteBussines();
      case 2:
        return SearchCartaPorte(
          value: null,
          totalcarta: 0,
        );
      // case 3:
      //   return SearchCartaPorte();
      default:
        return LicenciaValidate();
    }
  }

  setStatePage(int index) => setState(() => _page = index);
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    final alert = AlertDialog(
      scrollable: true,
      elevation: 2.0,
      actionsOverflowButtonSpacing: 5.0,
      actions: [
        Container(
          margin: EdgeInsets.only(left: 10, right: 5),
          child: FlatButton(
              child: const Text(
                "Cancelar",
                style: TextStyle(color: kGrisColor),
              ),
              onPressed: () {
                _page = 1;
                Navigator.of(context).pop();
              }),
        ),
        Container(
            margin: const EdgeInsets.only(left: 5, right: 10),
            child: FlatButton(
              child: const Text(
                "Cerrar",
                style: TextStyle(color: kRojoColor),
              ),
              onPressed: () async {
                _sharedPreference.removeOne(ISLICENCIA);
                _sharedPreference.removeOne(TOKENMOVIL);
                _sharedPreference.removeOne(LICENCIA);
                _sharedPreference.removeOne(LOGGEDIN);
                _sharedPreference.removeOne(USERSTATUS);
                _sharedPreference.removeOne(ESTATUS);
                prefs.dataList = false;

                Navigator.pushReplacementNamed(context, '/');
              },
            ))
      ],
      contentPadding: EdgeInsets.zero,
      content: FractionallySizedBox(
          widthFactor: 1,
          child: Column(
            children: <Widget>[
              Container(
                width: SizeConfig.widthMultiplier! * 100,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0))),
                child: const Text(
                  "Cerrar sesion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kTextWhiteColor,
                      fontSize: 28.0),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 15, left: 15),
                child: const Text(
                  "¿Esta seguro que desea cerrar la sesion?",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18.0),
                ),
              ),
            ],
          )),
    );

    return WillPopScope(
      onWillPop: () async {
        if (_page == 2) setStatePage(2);
        if (_page != 0) setStatePage(0);
        if (_page == 0) {
          await navigatorKey.currentState!.maybePop();
          return true;
        }
        return false;
      },
      child: Scaffold(
        key: mScaffoldState,
        backgroundColor: kPrimaryColor,
        appBar: null,
        body: SafeArea(child: _callPage(_page)),
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomNavigationBar,
          index: _page > 2 ? 0 : _page,
          letIndexChange: (value) => true,
          height: 50.0,
          backgroundColor: Color.fromRGBO(1, 55, 89, 35),
          items: const <Widget>[
            Icon(Icons.account_circle, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.exit_to_app, size: 30),
          ],
          onTap: (index) {
            if (index != 2) setStatePage(index);
            if (index == 2) {
              showDialog(context: context, builder: (context) => alert);
            }
          },
        ),
      ),
    );
  }

  void _SendLicencia(BuildContext context) async {
    _sharedPreference.saveValueString(licenciaController!.text, email);
  }
}
