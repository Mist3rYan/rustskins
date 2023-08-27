import 'package:flutter/material.dart';


class AppBarWidget extends AppBar{
AppBarWidget({super.key}):super(
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
    );
  }
