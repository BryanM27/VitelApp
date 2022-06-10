import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/models/response/cartaporterequest_model.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
import 'package:vitel_chat/src/services/downloadfiles_service.dart';
import '../global/constants.dart';

class SearchCartaPorte extends StatefulWidget {
  final DataModel? value;
  final int totalcarta;

  SearchCartaPorte({Key? key, required this.value, required this.totalcarta})
      : super(key: key);
  @override
  _SearchCartaPorte createState() => _SearchCartaPorte();
}

final _formKey = GlobalKey<FormState>();

class _SearchCartaPorte extends State<SearchCartaPorte> {
  final prefs = SharedPref.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Cartas Porte'),
      ), //AppBar
      body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: widget.totalcarta == null ? 0 : widget.totalcarta,
              itemBuilder: (context, index) {
                final cartaporte = widget.value?.cartaporte?[index];
                return Dismissible(
                  key: Key(cartaporte.folio),
                  background: Container(
                    color: Colors.green,
                    child: Align(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/xml.png'),
                          radius: 40,
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: Align(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/pdf.png'),
                          radius: 40,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      String? clientid = prefs.idClient;
                      String? tokenm = prefs.tokenMovil;
                      int? idcarta =
                          widget.value?.cartaporte?[index].idcartaporte;
                      int? idempres = prefs.idEmpresa;
                      Future<bool> isDownload =
                          downloadXML(clientid, idcarta, idempres, tokenm);
                      if (await isDownload) {
                        showToasDownload();
                      }

                      return false;
                    } else {
                      String? clientid = prefs.idClient;
                      String? tokenm = prefs.tokenMovil;
                      int? idcarta =
                          widget.value?.cartaporte?[index].idcartaporte;
                      int? idempres = prefs.idEmpresa;
                      Future<bool> isDownload =
                          downloadPDF(clientid, idcarta, idempres, tokenm);
                      if (await isDownload) {
                        showToasDownload();
                      }
                    }
                  },
                  onDismissed: (_) {
                    setState(() {
                      cartaporte.removeAt(index);
                    });
                  },
                  child: ListTile(
                    trailing: Text(
                        '${widget.value?.cartaporte?[index].fechainicioviaje}'),
                    leading: Icon(Icons.attach_file_rounded),
                    title: Text(
                        '${widget.value?.cartaporte?[index].folio} - ${widget.value?.cartaporte?[index].rfcclienteproovedor} ${widget.value?.cartaporte?[index].nombreclienteproovedor} '),
                    subtitle: Text('tipo  N/A '
                        ' | '
                        'Estatus: ${widget.value?.cartaporte?[index].estatus}'),
                    onTap: () async {
                      //  prefs.dataList = widget.value?.cartaporte?[index].folio;
                      prefs.idCartaPorte =
                          widget.value?.cartaporte?[index].idcartaporte;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctxt) => DetailCartaPorte(
                              values: widget.value!.cartaporte![index]),
                        ),
                      );

                      // debugPrint('${widget.value!.cartaporte![index]}');
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ) // center
          ),
    );
  }

  void showToasDownload() {
    Fluttertoast.showToast(
        msg: "¡Descarga exitosa!", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1 // duration
        );
  }
}
