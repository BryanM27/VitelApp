//import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:vitel_chat/src/global/size_config.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/response/cartaporte_model.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
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

  void _getCartaporte() async {
    final SharedPreference _sharedPreference = SharedPreference();
    String token = await _sharedPreference.returnValueString(TOKENMOVIL);
    bool resp = await _cartaService!.getListCarta(token);
  }

  @override
  Widget build(BuildContext context) {
    _cartaService = Provider.of<CartaListService>(context);
    return SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(),
        onLoading: () {},
        onRefresh: _onRefresh,
        child: ContainerPortrait(
          carta: _cartaService!.carta,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text('Carta Porte'),
        ), //AppBar
        body: Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: const BoxDecoration(
            color: Colors.grey,
            // border:Color
          ),
          child: ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const FlutterLogo(),
                trailing: Text('$index'),
                title: Text(
                  '${widget.carta!.rfc}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('${widget.carta!.nombre}'),
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
