import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import 'package:app_resources/src/Widgets/ToastCustom.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/models/operador_model.dart';
import 'package:vitel_chat/src/models/response/prueba.dart';
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
  final DataModel? value;
  final int totalcarta;

  SearchCartaPorte({Key? key, required this.value, required this.totalcarta})
      : super(key: key);
  @override
  _SearchCartaPorte createState() => _SearchCartaPorte();
}

class _SearchCartaPorte extends State<SearchCartaPorte> {
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
            itemCount: widget.totalcarta == null ? 0 : widget.totalcarta,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: Text(
                    '${widget.value?.cartaporte?[index].fechainicioviaje}'),
                leading: const FlutterLogo(),
                title: Text(
                    '${widget.value?.cartaporte?[index].folio} - ${widget.value?.cartaporte?[index].rfcclienteproovedor} ${widget.value?.cartaporte?[index].nombreclienteproovedor} '),
                subtitle: Text('tipo  N/A '
                    ' | '
                    'Estatus: ${widget.value?.cartaporte?[index].estatus}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctxt) => DetailCartaPorte(
                          values: widget.value!.cartaporte![index]),
                    ),
                  );
                  // debugPrint('${widget.value!.cartaporte![index]}');
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
