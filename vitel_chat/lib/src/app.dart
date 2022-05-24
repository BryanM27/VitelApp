import 'package:vitel_chat/src/global/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vitel_chat/src/pages/home.dart';

import 'global/constants.dart';
import 'package:vitel_chat/src/pages/home.dart';
import 'package:vitel_chat/src/pages/landing_page.dart';
import 'package:vitel_chat/src/services/user_services.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  bool loggedin = false;

  @override
  void initState() {
    super.initState();
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
              // ChangeNotifierProvider(create: (_) => BinnacleService()),
              ChangeNotifierProvider(create: (_) => UserService()),
              // ChangeNotifierProvider(create: (_) => AuthService()),
            ],
            child: MaterialApp(
              title: 'Grupo GIT',
              navigatorKey: navigatorKey,
              theme: ThemeData(
                primaryColor: kSelectorColor,
              ),
              debugShowCheckedModeBanner: false,
              routes: {
                '/': (BuildContext context) => LandingPage(),
                '/login': (BuildContext context) => LoginPage(),
                // '/home': (BuildContext context) => HomePage(),
                // '/password': (BuildContext context) => RecoveryPassword(),
              },
            ),
          );
        });
      },
    );
  }
}
