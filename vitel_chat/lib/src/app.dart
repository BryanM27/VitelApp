import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'package:vitel_chat/src/pages/auth/login_page.dart';
import 'package:vitel_chat/src/pages/auth_login.dart';
import 'package:vitel_chat/src/pages/detailcartaporte_page.dart';
import 'package:vitel_chat/src/pages/home_page.dart';
import 'package:vitel_chat/src/pages/searchcartaporte_page.dart';
import 'package:vitel_chat/src/services/listacarta_service.dart';

import 'global/constants.dart';
import 'package:vitel_chat/src/pages/auth_login.dart';
import 'package:vitel_chat/src/pages/fragments/landing_page.dart';
import 'package:vitel_chat/src/services/user_services.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final prefs = SharedPref.instance;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  bool loggedin = false;

  @override
  void initState() {
    super.initState();
    // prefs.firstLogin = true;
    // final pushProvider = new PushNotificationsService();
    // pushProvider.initNotifications();

    // pushProvider.mensajesStream.listen((data) {
    //   navigatorKey.currentState!.pushNamed('mensaje', arguments: data);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizeConfig().init(constraints, orientation);
          return MultiProvider(
            providers: [
              // ChangeNotifierProvider(create: (_) => RequestService()),
              // ChangeNotifierProvider(create: (_) => ChecksService()),
              ChangeNotifierProvider(create: (_) => CartaListService()),
              ChangeNotifierProvider(create: (_) => UserService()),
              //ChangeNotifierProvider(create: (_) => getCartaporte()),
            ],
            child: MaterialApp(
              title: 'VENGOVOY',
              navigatorKey: navigatorKey,
              theme: ThemeData(
                primaryColor: kPrimaryColor,
              ),
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (BuildContext context) => LandingPage(),
                '/login': (BuildContext context) => LoginAuthPage(),
                '/home': (BuildContext context) => HomePage(),
                // '/details': (BuildContext context) => SearchCartaPorte(),
                //carta': (BuildContext context) => DetailCartaPorte(),
                // '/password': (BuildContext context) => RecoveryPassword(),
              },
            ),
          );
        });
      },
    );
  }
}
