import 'package:flutter/material.dart';
import 'package:vitel_chat/src/helpers/shared.dart';
import 'src/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPref.initPrefs();
  runApp(MyApp());
}
