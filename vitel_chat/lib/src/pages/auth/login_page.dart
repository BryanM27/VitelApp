import 'package:fluttertoast/fluttertoast.dart';
import 'package:vitel_chat/src/global/constants.dart';
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

class LoginAuthPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginAuthPage> {
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(250, 255, 255, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: SizeConfig.isMobilePortrait ? 40 : 10,
                    ),
                    // padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Center(
                          //margin: EdgeInsets.only(right: 5),
                          child: Image.asset(
                            'assets/images/LOGO_Vengo_Voy.png',
                            height: 120,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
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
                                Text('Recordar usuario')
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
                        SizeConfig.isMobilePortrait
                            ? Divider(
                                height: 100.0,
                                color: kPrimaryColor,
                                thickness: 2.0,
                                indent: 20.0,
                                endIndent: 20.0,
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                  // Divisor
                ],
              ),
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
  void showToaslogin() {
    Fluttertoast.showToast(
        msg: "Usuario o contraseña incorrecto", // message
        toastLength: Toast.LENGTH_SHORT, // length
        gravity: ToastGravity.CENTER, // location
        timeInSecForIosWeb: 1 // duration
        );
  }

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
        prefs.rememberPassword = passwordController!.text;
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        showToaslogin();
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
    if (prefs.rememberUser == true) {
      isChecked = true;
    }
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
        if (value == false) {
          prefs.userEmail = '';
          prefs.rememberPassword = '';
        }
      },
    );
  }
}
