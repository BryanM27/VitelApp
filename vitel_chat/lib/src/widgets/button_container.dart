// ignore_for_file: deprecated_member_use

import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';

import '../global/constants.dart';

class ButtonContainer extends StatelessWidget {
  final String? text;
  final Function? onPressed;
  final Color? colorbg;
  final Color? colortext;
  const ButtonContainer(
      {Key? key, this.text, this.onPressed, this.colorbg, this.colortext})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // decoration: BoxDecoration(
      //   color: Color.fromARGB(248, 7, 7, 230)
      // ),
      margin: SizeConfig.isMobilePortrait
          ? EdgeInsets.only(top: 15, bottom: 40)
          : EdgeInsets.only(bottom: 15),
      width: size.width * 0.75,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: RaisedButton(
          padding: const EdgeInsets.all(20),
          disabledColor: Colors.amber,
          child: Text(
            text!,
            style: TextStyle(
                color: colortext == null
                    ? Color.fromARGB(255, 255, 255, 255)
                    : colortext),
          ),
          splashColor: Color.fromARGB(26, 43, 217, 85),
          color: kPrimaryColor,
          onPressed: () {
            onPressed!();
          },
        ),
      ),
    );
  }
}
