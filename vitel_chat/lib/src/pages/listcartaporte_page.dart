//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:vitel_chat/src/global/size_config.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
//import 'package:vitel_chat/src/models/response/cartaporte_model.dart';
import 'package:vitel_chat/src/models/response/cartaporterequest_model.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
import 'package:vitel_chat/src/pages/searchcartaporte_page.dart';
import 'package:vitel_chat/src/services/listacarta_service.dart';
import '../global/constants.dart';

class ListOperadores extends StatefulWidget {
  const ListOperadores({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ListOperadores createState() => _ListOperadores();
}

class _ListOperadores extends State<ListOperadores> {
  CartaListService? _cartaService;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final responseBool = new StreamController<bool>();
  final prefs = SharedPref.instance;

  @override
  void initState() {
    super.initState();
    _getCartaporte();
    responseBool.sink.add(true);
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _getCartaporte();
    _refreshController.refreshCompleted();
  }

  Future _getCartaporte() async {
    final SharedPreference _sharedPreference = SharedPreference();
    final prefs = SharedPref.instance;

    String? token = await _sharedPreference.returnValueString(TOKENMOVIL);
    String? lic = prefs.licenciaUser!;
    if (await token != null && await lic != '') {
      Future<bool> resp = _cartaService!.getListCarta(token, lic);
      if (await resp == true) {
        responseBool.sink.add(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _cartaService = Provider.of<CartaListService?>(context);
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropHeader(),
      onLoading: () {},
      onRefresh: _onRefresh,
      child: StreamBuilder(
        stream: responseBool.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (prefs.validarLicencia == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ContainerPortrait(
            carta: _cartaService?.carta,
          );
        },
      ),
    );
    ;
  }
}

class ContainerPortrait extends StatefulWidget {
  final CartaModelResp? carta;
  const ContainerPortrait({
    Key? key,
    this.carta,
  }) : super(key: key);

  @override
  _ContainerPortraitState createState() => _ContainerPortraitState();
}

class _ContainerPortraitState extends State<ContainerPortrait> {
  final _formKey = GlobalKey<FormState>();
  final SharedPreference _sharedPreference = SharedPreference();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final prefs = SharedPref.instance;
  int? totalcout;
  int? totalcarta;

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await _getValue();
    _refreshController.refreshCompleted();
  }

  _getValue() async {
    totalcout = await _sharedPreference.returnValueInt(conteo);
    totalcarta = await _sharedPreference.returnValueInt(TOTALCARTA);
    if (await totalcout != null &&
        totalcout != 0 &&
        totalcarta != null &&
        totalcarta != 0) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Center(
            child: Row(children: <Widget>[
              Expanded(
                child: Align(
                    alignment: Alignment.topLeft, child: Text("CartaPorte")),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text('${prefs.licenciaUser}')),
              ),
            ]),
          )), //AppBar
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 239, 239),

            // border:Color
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: totalcout == null ? 0 : totalcout!,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.add_business_rounded),
                trailing: Text('$totalcarta'),
                title: Text(
                  '${widget.carta?.data?[index].rfc} aaaaaaaaaaa',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('${widget.carta?.data?[index].nombre}',
                    style: TextStyle(fontSize: 12)),
                onTap: () {
                  //debugPrint('${widget.carta?.data?[index].nombre}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctxt) => SearchCartaPorte(
                        value: widget.carta!.data![index],
                        totalcarta: totalcarta!,
                      ),
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          ),
        ),
      ),
    ); // center
  }
}
