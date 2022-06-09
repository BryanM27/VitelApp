import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:vitel_chat/src/models/loginmovil_model.dart';
import 'package:vitel_chat/src/services/auth_service.dart';
import 'package:vitel_chat/src/widgets/button_container.dart';
import 'package:vitel_chat/src/widgets/textfield_passwordcontainer.dart';
import 'package:vitel_chat/src/widgets/textfield_container.dart';

import '../global/constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthService? authProvider = AuthService();

  final SharedPreference _sharedPreference = SharedPreference();

  TextEditingController? emailController;

  TextEditingController? passwordController;
  final prefs = SharedPref.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    //emailController?.text = 'hola';
    super.initState();
  }

  validator() {
    // print(_formKey.currentState!.validate());

    // if(!_formKey.currentState!.validate()) return;

    // _formKey.currentState!.save();
  }
  @override
  Widget build(BuildContext context) {
    //  authProvider = Provider.of<AuthService>( context );
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 255, 255, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // Logos
                Container(
                  margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.isMobilePortrait ? 60 : 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Image.asset(
                          'assets/images/LOGO_Vengo_Voy.png',
                          height: 120,
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                //Email
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFieldContainer(
                          controller: emailController,
                          text: "Email",
                          keyboard: TextInputType.emailAddress,
                          icon: Icons.alternate_email,
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: TextFieldPasswordContainer(
                            controller: passwordController,
                            text: "Contraseña",
                            icon: Icons.vpn_key,
                            suffixIcon: Icons.visibility,
                            suffixIcon2: Icons.visibility_off),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            child: Row(children: <Widget>[
                              MyStatefulWidget(),
                              Text('Recordar correo')
                            ]),
                          )
                        ],
                      ),
                      ButtonContainer(
                        text: "Iniciar sesión",
                        onPressed: () {
                          _login(context);
                        },
                      ),
                      // Divisor
                      SizeConfig.isMobilePortrait
                          ? Divider(
                              height: 100.0,
                              color: kPrimaryColor,
                              thickness: 2.0,
                              indent: 30.0,
                              endIndent: 30.0,
                            )
                          : Text(""),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildShowDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
            child: CircularProgressIndicator(),
          ));

  void _login(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      buildShowDialog(context);
      _sharedPreference.saveValueString(emailController!.text, email);
      _sharedPreference.saveValueString(passwordController!.text, password);

      final login = LoginMovilModel(
        email: emailController!.text,
        password: passwordController!.text,
        // tokenmovil: "Token",
      );

      bool resp = await authProvider!.login(login);

      if (await resp) {
        prefs.userEmail = emailController!.text;
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        prefs.rememberUser = false;
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(new FocusNode());
        //ToastCustom().getToastError(context);
      }
      return;
    }
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool isChecked = false;
  final prefs = SharedPref.instance;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.red;
      }
      return Colors.blue;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        prefs.rememberUser = value;
      },
    );
  }
}
