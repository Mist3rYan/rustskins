import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:rustskins/screens/home.dart';
import 'package:rustskins/services/steam_login.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const pageName = '/';

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  String steamId = '';

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
            Image.asset(
              'assets/images/logo_1024.png',
              height: 200,
            ),
            GestureDetector(
              onTap: () async {
                // Navigate to the login page.
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SteamLogin()));
                setState(() {
                  steamId = result;
                  if (steamId != '') {
                    Navigator.pushNamed(context, Home.pageName,
                        arguments: steamId);
                  }
                });
              },
              child: Container(
                margin: const EdgeInsets.only(top: 75.0),
                height: 48,
                child: Image.asset('assets/images/sign_steam_L.png',
                    fit: BoxFit.contain),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SteamLogin extends StatelessWidget {
  final _webView = FlutterWebviewPlugin();

  SteamLogin({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the onUrlChanged events, and when we are ready to validate do so.
    _webView.onUrlChanged.listen((String url) async {
      var openId = OpenId.fromUri(Uri.parse(url));
      if (openId.mode == 'id_res') {
        await _webView.close();
        if (context.mounted) Navigator.of(context).pop(openId.validate());
      }
    });

    var openId = OpenId.raw('https://myapp', 'https://myapp/', {});
    return WebviewScaffold(
      url: openId.authUrl().toString(),
    );
  }
}
