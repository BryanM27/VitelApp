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
import 'package:vitel_chat/src/widgets/button_container.dart';
import 'package:vitel_chat/src/widgets/textfield_passwordcontainer.dart';
import 'package:vitel_chat/src/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

import '../global/constants.dart';

class SearchCartaPorte extends StatefulWidget {
  final int? _Page = 0;
  const SearchCartaPorte({
    Key? key,
  }) : super(key: key);
  @override
  _SearchCartaPorte createState() => _SearchCartaPorte();
}

class _SearchCartaPorte extends State<SearchCartaPorte> {
  //AuthService? authProvider = AuthService();

  final SharedPreference _sharedPreference = SharedPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: const Text('Listado de cartaportes'),
        ), //AppBar
        body: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: 15,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: const Text('Fecha'),
                leading: const FlutterLogo(),
                title: Text('CP- $index'),
                subtitle: Text('tipo $index' ' | ' 'Estatus' ' $index'),
                onTap: () {
                  setState(() {});
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ) // center
        );
  }
}
