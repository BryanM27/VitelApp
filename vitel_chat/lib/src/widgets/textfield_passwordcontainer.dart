import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import '../global/constants.dart';

class TextFieldPasswordContainer extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final IconData? suffixIcon;
  final IconData? suffixIcon2;
  final TextEditingController? controller;
  TextFieldPasswordContainer(
      {Key? key,
      this.controller,
      this.text,
      this.icon,
      this.suffixIcon,
      this.suffixIcon2})
      : super(key: key);

  @override
  _TextFieldPasswordContainerState createState() =>
      _TextFieldPasswordContainerState();
}

class _TextFieldPasswordContainerState
    extends State<TextFieldPasswordContainer> {
  // Initially password is obscure
  bool _obscureText = true;
  String? _password;
  final prefs = SharedPref.instance;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (prefs.rememberUser == true) {
      widget.controller?.text = prefs.rememberPassword!;
    }
    return Container(
      margin: EdgeInsets.only(
          top: 20, bottom: SizeConfig.isMobilePortrait ? 10 : 20),
      child: TextFormField(
          controller: widget.controller,
          onSaved: (value) => _password = value,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Introduce tu contraseña';
            }
            return null;
          },
          obscureText: _obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 23.0, top: 38.0),
            filled: true,
            fillColor: kTextWhiteColor,
            prefixIcon: Icon(
              widget.icon,
              color: kPrimaryColor,
            ),
            hintText: widget.text,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? widget.suffixIcon : widget.suffixIcon2,
                color: kPrimaryColor,
              ),
              onPressed: _toggle,
            ),
            errorStyle: TextStyle(
              color: Colors.red,
            ),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          )),
    );
  }
}
