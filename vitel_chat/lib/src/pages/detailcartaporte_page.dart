import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/models/response/prueba.dart';
import 'package:vitel_chat/src/widgets/doublerow_container.dart';
import 'package:vitel_chat/src/widgets/textbold_container.dart';

class DetailCartaPorte extends StatefulWidget {
  final CartaModel? values;

  DetailCartaPorte({
    Key? key,
    required this.values,
  }) : super(key: key);
  @override
  _DetailCartaPorte createState() => _DetailCartaPorte();
}

class _DetailCartaPorte extends State<DetailCartaPorte> {
  final f = new DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Detalles cartaporte '),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
              height: 780,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                color: Colors.grey.shade300,
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 10.0),
                    child: Center(
                      child: Text(
                        '${widget.values?.folio}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          //Item 2/4
                          Expanded(
                            child: Container(
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/xml.png'),
                                radius: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Center(
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/images/pdf.png'),
                                  radius: 40,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      //Datos BD
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TextBoldContainer(
                              title: "Cliente",
                              info: '${widget.values?.rfcclienteproovedor} || '
                                  '${widget.values?.nombreclienteproovedor}',
                            ),
                            TextBoldContainer(
                              title: "Fecha de inicio",
                              info: '${widget.values?.fechainicioviaje}',
                              // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Column(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: <Widget>[
                                    const Center(
                                      child: Text(
                                        'Información Vehículo',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ]),
                            ),
                            TextBoldContainer(
                              title: "Tipo Transporte",
                              info:
                                  "${widget.values?.tipovehiculo != "" ? widget.values?.tipovehiculo : "No hay información."}",
                              // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                            ),
                            Row(
                              children: <Widget>[
                                //Item 2/4
                                Expanded(
                                  child: Center(
                                      child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: TextBoldContainer(
                                      title: "Placas",
                                      info:
                                          "${widget.values?.placasvehiculo != "" ? widget.values?.placasvehiculo : "No hay información."}",
                                      // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                    ),
                                  )),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBoldContainer(
                                        title: "Modelo",
                                        info:
                                            "${widget.values?.modelovehiculo != "" ? widget.values?.modelovehiculo : "No hay información."}",
                                        // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextBoldContainer(
                              title: "Tipo Permiso",
                              info:
                                  "${widget.values?.vehiculopermiso != "" ? widget.values?.vehiculopermiso : "No hay información."}",
                              // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                            ),
                            Row(
                              children: <Widget>[
                                //Item 2/4
                                Expanded(
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBoldContainer(
                                        title: "Numero Permiso",
                                        info:
                                            "${widget.values?.permisovehiculo != "" ? widget.values?.permisovehiculo : "No hay información."}",
                                        // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: TextBoldContainer(
                                        title: "Nombre Asegurado",
                                        info:
                                            "${widget.values?.aseguradora != "" ? widget.values?.aseguradora : "No hay información."}",
                                        // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextBoldContainer(
                              title: "Número Póliza",
                              info:
                                  "${widget.values?.polizavehiculo != "" ? widget.values?.polizavehiculo : "No hay informaciinformación."}",
                              // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
