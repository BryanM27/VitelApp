import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
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
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // Logos
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.isMobilePortrait ? 50 : 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: SvgPicture.asset(
                        'assets/images/logo_icon_git.svg',
                        height: 75,
                      ),
                    ),
                    Container(
                      child:
                          SvgPicture.asset('assets/images/logo_text_git.svg'),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
              //Email
              FractionallySizedBox(
                widthFactor: 0.8,
                child: TextFieldContainer(
                  controller: emailController,
                  text: "Email",
                  keyboard: TextInputType.emailAddress,
                  icon: Icons.alternate_email,
                ),
              ),
              //Password
              FractionallySizedBox(
                widthFactor: 0.8,
                child: TextFieldPasswordContainer(
                    controller: passwordController,
                    text: "Contraseña",
                    icon: Icons.vpn_key,
                    suffixIcon: Icons.visibility,
                    suffixIcon2: Icons.visibility_off),
              ),
              // Button Iniciar Sesion
              ButtonContainer(
                text: "Iniciar Sesión",
                onPressed: () {
                  _login(context);
                },
              ),
              // Divisor
              SizeConfig.isMobilePortrait
                  ? Divider(
                      height: 100.0,
                      color: kDividerColor,
                      thickness: 2.0,
                      indent: 30.0,
                      endIndent: 30.0,
                    )
                  : Text(""),
              //Recuperar contraseña
              // Container(
              //   margin: SizeConfig.isMobilePortrait
              //       ? EdgeInsets.only(bottom: 50)
              //       : EdgeInsets.zero,
              //   child: InkWell(
              //     onTap: () => Navigator.pushNamed(context, '/password'),
              //     child: Text(
              //       "¿Se te olvidó tu contraseña?",
              //       style: TextStyle(
              //         color: kTextWhiteColor,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 15.0,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        )),
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

      if (resp) {
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(new FocusNode());
        //ToastCustom().getToastError(context);
      }
      return;
    }
  }
}
