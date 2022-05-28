import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:app_resources/src/Widgets/ToastCustom.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
// import 'package:app_resources/src/models/LoginMovil_model.dart';
import 'package:vitel_chat/src/services/auth_service.dart';
import 'package:vitel_chat/src/widgets/button_container.dart';
import 'package:vitel_chat/src/widgets/textfield_passwordcontainer.dart';
import 'package:vitel_chat/src/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

import '../global/constants.dart';

class SearchCartaPorte extends StatefulWidget {
  @override
  _SearchCartaPorte createState() => _SearchCartaPorte();
}

class _SearchCartaPorte extends State<SearchCartaPorte> {
  //AuthService? authProvider = AuthService();

  final SharedPreference _sharedPreference = SharedPreference();

  validator() {
    // print(_formKey.currentState!.validate());

    // if(!_formKey.currentState!.validate()) return;

    // _formKey.currentState!.save();
  }
  @override
  Widget build(BuildContext context) {
    // backing data
    final int viewCount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Listado de cartaportes'),
      ), //AppBar
      body: Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          itemCount: 15,
          itemBuilder: (context, index) {
            return ListTile(
              leading: FlutterLogo(),
              title: Text('row $index'),
              subtitle: Text('Empresa $index'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/details');
                debugPrint("On tap $index");
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ), // center
    );
  }
}
