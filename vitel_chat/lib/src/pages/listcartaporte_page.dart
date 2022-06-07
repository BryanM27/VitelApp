//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:vitel_chat/src/global/size_config.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
//import 'package:vitel_chat/src/models/response/cartaporte_model.dart';
import 'package:vitel_chat/src/models/response/prueba.dart';
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

  @override
  void initState() {
    super.initState();
    _getCartaporte();
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _getCartaporte();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  Future _getCartaporte() async {
    final SharedPreference _sharedPreference = SharedPreference();
    bool islic = await _sharedPreference.returnValueBoolean(ISLICENCIA);
    if (islic == true) {
      String token = await _sharedPreference.returnValueString(TOKENMOVIL);
      String lic = await _sharedPreference.returnValueString(LICENCIA);
      bool resp = await _cartaService!.getListCarta(token, lic);
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
        child: ContainerPortrait(
          carta: _cartaService?.carta,
        ));
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

  int? totalcout;
  int? totalcarta;

  @override
  void initState() {
    super.initState();
    _getValue();
  }

  void _onRefresh() async {
    _getCartaporte();
    await Future.delayed(Duration(milliseconds: 1000));
    _getValue();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    _refreshController.loadComplete();
  }

  _getValue() async {
    totalcout = await _sharedPreference.returnValueInt(conteo);
    totalcarta = await _sharedPreference.returnValueInt(TOTALCARTA);
    _onRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Carta Porte'),
      ), //AppBar
      body: totalcarta == null || totalcarta == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
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
                      leading: const FlutterLogo(),
                      trailing: Text('$totalcarta'),
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
            ), // center
    );
  }

  Widget _getCartaporte() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
