import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/login.dart';

class AppBarWidget extends AppBar {
  AppBarWidget(BuildContext context, {super.key})
      : super(
          backgroundColor: const Color(0xFF000000),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_simple.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Rustskins',
                  style: TextStyle(
                    color: Color(0xFFbf8700),
                    fontFamily: 'Rust',
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await removeDataFromSharedPreferences();
                // ignore: use_build_context_synchronously
                Navigator.pushNamed(context, Login.pageName);
                // Ajoutez ici le code pour la redirection
                // Par exemple, vous pouvez utiliser Navigator pour naviguer vers une autre page.
              },
            ),
          ],
        );
}

Future<void> removeDataFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('iconeUrl');
  prefs.remove('pseudo');
  prefs.remove('steamId');
}
