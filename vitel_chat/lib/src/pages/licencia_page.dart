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

class Licencia extends StatefulWidget {
  @override
  _Licencia createState() => _Licencia();
}

class _Licencia extends State<Licencia> {
  int _page = 0;
  final SharedPreference _sharedPreference = SharedPreference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Carta Porte'),
        ), //AppBar
        body: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: 15,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const FlutterLogo(),
                trailing: Text('$index'),
                title: Text('Carta Porte $index'),
                subtitle: Text('Empresa $index'),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (ctxt) => const DetailCartaPorte()),
                  // );
                  debugPrint("On tap $index");
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
