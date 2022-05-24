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
      margin: SizeConfig.isMobilePortrait
          ? EdgeInsets.only(top: 25, bottom: 30)
          : EdgeInsets.only(bottom: 15),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: RaisedButton(
          disabledColor: Colors.amber,
          child: Text(
            text!,
            style:
                TextStyle(color: colortext == null ? kPrimaryColor : colortext),
          ),
          splashColor: Colors.amber,
          color: Colors.white,
          onPressed: () {
            print("Modulo " + text!);
            onPressed!();
          },
        ),
      ),
    );
  }
}
