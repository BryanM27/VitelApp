import 'package:flutter/material.dart';
import 'package:vitel_chat/src/global/constants.dart';

class DetailCartaPorte extends StatelessWidget {
  //final UserModel? user;
  const DetailCartaPorte({
    Key? key,
    //this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Detalles cartaporte'),
      ),
      body: Container(),
    );
  }
}
