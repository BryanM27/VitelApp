import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vitel_chat/src/app.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
import 'package:vitel_chat/src/pages/fragments/register_license.dart';
import 'package:vitel_chat/src/pages/listcartaporte_page.dart';
import 'package:vitel_chat/src/pages/searchcartaporte_page.dart';
import 'package:vitel_chat/src/services/cartaporte_services.dart';

import '../global/constants.dart';
import '../global/size_config.dart';
import '../widgets/button_container.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 0;

  SharedPreference _sharedPreference = SharedPreference();
  TextEditingController? licenciaController;

  GlobalKey<ScaffoldState> mScaffoldState = GlobalKey<ScaffoldState>();
  GlobalKey bottomNavigationBar = GlobalKey();

  Widget _callPage(int actuallyPage) {
    switch (actuallyPage) {
      case 0:
        return _homeWidget();
      // case 1:
      //   return RegisterLicense();
      case 1:
        return ListOperadores();
      case 2:
        return DetailCartaPorte();
      // case 3:
      //   return SearchCartaPorte();
      default:
        return _homeWidget();
    }
  }

  setStatePage(int index) => setState(() => _page = index);
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  Widget _homeWidget() => Center(
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
                TextFormField(
                  controller: licenciaController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Numero de licencia',
                  ),
                ),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    getCartaporte();
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      );

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
            child: Text(
              "Cancelar",
              style: TextStyle(color: kGrisColor),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        Container(
            margin: EdgeInsets.only(left: 5, right: 10),
            child: FlatButton(
              child: Text(
                "Cerrar",
                style: TextStyle(color: kRojoColor),
              ),
              onPressed: () {
                _sharedPreference.removeAll();
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
                padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0))),
                child: Text(
                  "Cerrar sesion",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kTextWhiteColor,
                      fontSize: 28.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, right: 15, left: 15),
                child: Text(
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
          index: _page > 3 ? 0 : _page,
          letIndexChange: (value) => true,
          height: 50.0,
          backgroundColor: Color.fromRGBO(1, 55, 89, 35),
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.account_circle, size: 30),
            Icon(Icons.exit_to_app, size: 30),
          ],
          onTap: (index) {
            if (index != 3) setStatePage(index);
            if (index == 3)
              showDialog(context: context, builder: (context) => alert);
          },
        ),
      ),
    );
  }
}
