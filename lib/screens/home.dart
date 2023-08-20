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
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
