import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'config/config.dart';

import 'screens/home.dart';

Future main() async {
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Config.colors.primaryColor,
      ),
      home: const Home(),
    );
  }
}
