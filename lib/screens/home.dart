import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//ICI LES VARIABLES ET METHODES

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Se connecter",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontFamily: 'Rust',
              ),
            ),
            Image.asset(
              'assets/images/logo_1024.png',
              height: 200,
            ),
            TextButton(
                onPressed: () {
                  print("Connexion avec Steam");
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "Se connecter avec Steam",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
