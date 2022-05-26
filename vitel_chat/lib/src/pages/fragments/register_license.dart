import 'package:flutter/material.dart';

class RegisterLicense extends StatefulWidget {
  @override
  _RegisterLicense createState() => _RegisterLicense();
}

class _RegisterLicense extends State<RegisterLicense> {
  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text('My Page!'),
      ),
    );
  }
}
