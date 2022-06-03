import 'package:flutter/material.dart';
import 'package:vitel_chat/src/global/constants.dart';
import 'package:vitel_chat/src/models/response/prueba.dart';
import 'package:vitel_chat/src/widgets/doublerow_container.dart';
import 'package:vitel_chat/src/widgets/textbold_container.dart';

class DetailsCartaPorte extends StatefulWidget {
  final CartaModel? values;

  DetailsCartaPorte({
    Key? key,
    required this.values,
  }) : super(key: key);
  @override
  _DetailsCartaPorte createState() => _DetailsCartaPorte();
}

class _DetailsCartaPorte extends State<DetailsCartaPorte> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Detalles cartaporte '),
      ),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Container(
            color: kPrimaryColor,
            child: ListView(
              children: <Widget>[
                Container(
                    height: 900,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      color: Color.fromARGB(255, 245, 241, 241),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      children: [
                        Column(
                          children: [
                            //Titulo
                            Text("aaaaaaaaaaaaaa"),
                            //Container de las imagenes
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(30),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/xmlimage.jpg'),
                                      radius: 40,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(30),
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/xmlimage.jpg'),
                                      radius: 40,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 1.0),
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: TextBoldContainer(
                                              title: "Cliente",
                                              info: "No hay INFORMACION"),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: TextBoldContainer(
                                              title: "Fecha",
                                              info: "No hay INFORMACION"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 10.0),
                                  child: Column(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      Center(
                                        child: Text(
                                          'Información Vehículo',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 6.0, horizontal: 3.0),
                                  child: Column(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: TextBoldContainer(
                                              title: "Tipo Transporte",
                                              info: "No hay INFORMACION "),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          //Item 2/4
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: TextBoldContainer(
                                                    title: "Placas",
                                                    info: "No hay INFORMACION"),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: TextBoldContainer(
                                                    title: "Modelo",
                                                    info: "No hay INFORMACION"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: TextBoldContainer(
                                              title: "Tipo Permiso",
                                              info: "No hay INFORMACION"),
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          //Item 2/4
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: TextBoldContainer(
                                                    title: "Numero Permiso",
                                                    info: "No hay INFORMACION"),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: TextBoldContainer(
                                                    title: "Nombre Aegurado",
                                                    info: "No hay INFORMACION"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(3),
                                          child: TextBoldContainer(
                                              title: "Numero Poliza",
                                              info: "No hay INFORMACION"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
