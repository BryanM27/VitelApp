import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Detalles cartaporte '),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
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
                            padding: const EdgeInsets.all(30),
                            child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/xmlimage.jpg'),
                              radius: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(30),
                            child: const Center(
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/pdfimage.jpg'),
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
                            info: '${widget.values?.rfcclienteproovedor}',
                          ),
                          const TextBoldContainer(
                            title: "Fecha de inicio",
                            info: "No hay información",
                            // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10.0),
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
                            info: "No hay información",
                            // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                          ),
                          Row(
                            children: <Widget>[
                              //Item 2/4
                              Expanded(
                                child: Center(
                                  child: TextBoldContainer(
                                    title: "Placas",
                                    info: '${widget.values?.placasvehiculo}',
                                    // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: TextBoldContainer(
                                    title: "Modelo",
                                    info: '${widget.values?.modelovehiculo}',
                                    // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TextBoldContainer(
                            title: "Tipo Permiso",
                            info: "No hay información",
                            // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                          ),
                          Row(
                            children: <Widget>[
                              //Item 2/4
                              Expanded(
                                child: Center(
                                  child: TextBoldContainer(
                                    title: "Numero Permiso",
                                    info: "No hay información",
                                    // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: TextBoldContainer(
                                    title: "Nombre Asegurado",
                                    info: '${widget.values?.aseguradora}',
                                    // info: "${user!.cellphone != "" ? user!.cellphone : "No hay información."}", EJEMPLO MAPEO
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const TextBoldContainer(
                            title: "Número Póliza",
                            info: "No hay información",
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
    );
  }
}
