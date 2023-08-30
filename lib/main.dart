import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:rustskins/models/item.dart';
import 'package:rustskins/screens/home.dart';
import 'package:rustskins/screens/item_list_screen.dart';
import 'package:rustskins/screens/item_screen.dart';
import 'package:rustskins/screens/login.dart';
import 'configs/config.dart';
import 'screens/test.dart';

Future main() async {
  await Future.delayed(const Duration(seconds: 1));
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
        primaryColor: ConfigApp.colors.primaryColor,
      ),
      initialRoute: '/login',
      routes: {
        Login.pageName: (context) => const Login(),
        Home.pageName: (context) => const Home(),
        ItemScreen.pageName: (context) => ItemScreen(
              item: Item('name', 'image', 'price', 'steamId', 'description'),
            ),
        ItemListScreen.pageName: (context) => const ItemListScreen(),
        Test.pageName: (context) => const Test(),
      },
    );
  }
}
