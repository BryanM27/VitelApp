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

class ListCartaPorteBussines extends StatefulWidget {
  const ListCartaPorteBussines({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ListCartaPorteBussines createState() => _ListCartaPorteBussines();
}

class _ListCartaPorteBussines extends State<ListCartaPorteBussines> {
  final _formKey = GlobalKey<FormState>();
  final prefs = SharedPref.instance;
  CartaListService? _cartaService;
  @override
  void initState() {
    super.initState();
    _getFirstData();
  }

  Future<bool> _getFirstData() async {
    String? token = prefs.tokenMovil;
    String? licnumber = prefs.licenciaUser;
    if (token == null || licnumber == null || licnumber == "") {
      return false;
    }
    bool resp = await _cartaService!.getListCarta(token, licnumber);
    if (await resp) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    _cartaService = Provider.of<CartaListService?>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Center(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Align(
                    alignment: Alignment.topLeft, child: Text("CartaPorte")),
              ),
              Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text('${prefs.licenciaUser}')),
              ),
            ],
          ),
        ),
      ), //AppBar
      body: FutureBuilder(
        future: _getFirstData(),
        builder: (_, AsyncSnapshot snapshot) {
          return snapshot.data == false || snapshot.data == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              // : Text('Cargado');
              : GetListCartaporteBussines(
                  carta: _cartaService?.carta,
                );
        },
      ),
    );
  }
}

class GetListCartaporteBussines extends StatefulWidget {
  final CartaModelResp? carta;

  const GetListCartaporteBussines({Key? key, required this.carta})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _getListCartaporteBussines createState() => _getListCartaporteBussines();
}

class _getListCartaporteBussines extends State<GetListCartaporteBussines> {
  final prefs = SharedPref.instance;

  @override
  Widget build(BuildContext context) {
    int? indexCarta = prefs.totalEmpresas;
    return Form(
      child: Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 243, 239, 239),

          // border:Color
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          itemCount: indexCarta! == 0 ? 1 : indexCarta,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.add_business_rounded),
              trailing: Text('${prefs.totalCartaPortes}'),
              title: Text(
                '${widget.carta?.data?[index].rfc}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('${widget.carta?.data?[index].nombre}',
                  style: TextStyle(fontSize: 12)),
              onTap: () {
                prefs.idClient = widget.carta?.data?[index].clienteid;
                prefs.idEmpresa = widget.carta?.data?[index].idempresa;
                //debugPrint('${widget.carta?.data?[index].nombre}');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctxt) => SearchCartaPorte(
                      value: widget.carta!.data![index],
                      totalcarta: prefs.totalCartaPortes!,
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
    );
  }
}
