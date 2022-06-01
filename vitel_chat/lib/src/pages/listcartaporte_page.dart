//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:app_resources/src/Widgets/ToastCustom.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:vitel_chat/src/models/response/cartaporte_model.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
import 'package:vitel_chat/src/pages/searchcartaporte_page.dart';
// import 'package:app_resources/src/models/LoginMovil_model.dart';
import 'package:vitel_chat/src/services/auth_service.dart';
import 'package:vitel_chat/src/services/cartaporte_services.dart';
import 'package:vitel_chat/src/widgets/button_container.dart';
import 'package:vitel_chat/src/widgets/textfield_passwordcontainer.dart';
import 'package:vitel_chat/src/widgets/textfield_container.dart';
import 'package:provider/provider.dart';

import '../global/constants.dart';

class ListOperadores extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ListOperadores createState() => _ListOperadores();
}

class _ListOperadores extends State<ListOperadores> {
  // final RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  CartaModelResp? carta;

  // @override
  // void initState() {
  //   super.initState();
  //   _getCartaporte();
  // }

  // void _onRefresh() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use refreshFailed()
  //   _getCartaporte();
  //   _refreshController.refreshCompleted();
  // }

  // void _onLoading() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use loadFailed(),if no data return,use LoadNodata()
  //   _refreshController.loadComplete();
  // }

  // void _getCartaporte() async {
  //   final SharedPreference _sharedPreference = SharedPreference();
  //   //int id = await _sharedPreference.returnValueInt(USERID);
  //   await getCartaporte();
  // }

  @override
  Widget build(BuildContext context) {
    // carta == Provider.of<CartaModelResp>(context);
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
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const FlutterLogo(),
                trailing: Text('$index'),
                title:
                    Text('Carta Porte ${carta?.cartaporte?[0].idcartaporte}'),
                subtitle: Text('Empresa $index'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctxt) => const DetailCartaPorte()),
                  );
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
