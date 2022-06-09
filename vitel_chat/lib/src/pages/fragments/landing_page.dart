import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/helpers/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../../global/constants.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final SharedPreference _sharedPreference = SharedPreference();
  final prefs = SharedPref.instance;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500), () => _loadUserInfo());
  }

  _loadUserInfo() async {
    _sharedPreference.returnValueBoolean(LOGGEDIN).then((value) {
      if (value == false) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login', ModalRoute.withName('/login'));
      } else {
        prefs.firstLogin = true;
        Navigator.pushNamedAndRemoveUntil(
            context, '/home', ModalRoute.withName('/home'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: CircularProgressIndicator(
            backgroundColor: Color.fromARGB(29, 161, 242, 95),
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  }
}
