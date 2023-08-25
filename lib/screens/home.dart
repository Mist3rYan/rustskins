import 'package:flutter/material.dart';
import 'package:rustskins/steam/steam_login.dart';
//Navigator.pushNamed(context, Home.pageName,arguments: openId),
//8EBAEF7DA5E71DA6D942BA6E26D26A00
//https://steamcommunity.com/profiles/76561197994719101/inventory/#252490
//https://api.steampowered.com/IInventoryService/GetInventory/v1/?appid=252490&steamid=76561197994719101&key=8EBAEF7DA5E71DA6D942BA6E26D26A00&format=xml
//https://steamcommunity.com/inventory/76561197994719101/252490/2

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const pageName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//ICI LES VARIABLES ET METHODES
  var apikey = '8EBAEF7DA5E71DA6D942BA6E26D26A00';
  Map<String, dynamic>? summaries;
  var playerId = "76561199253595436";
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    summaries = await getPlayerSummaries(playerId, apikey);
    setState(
        () {}); // Met à jour l'interface utilisateur après avoir obtenu les données
  }

  @override
  Widget build(BuildContext context) {
    playerId = ModalRoute.of(context)!.settings.arguments as String;
    return summaries == null
        ? const Center(
            child: SizedBox(
              height: 50.0,
              width: 50.0,
              child: CircularProgressIndicator(
                color: Color(0xFFbf8700),
              ),
            ),
          ) // Peut afficher un indicateur de chargement tant que les données ne sont pas prêtes
        : Scaffold(
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
                  Image.network(summaries!['avatarfull'], height: 200),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      "Bonjour ",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Rust',
                      ),
                    ),
                    Text(
                      summaries!['personaname'],
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Rust',
                      ),
                    ),
                  ]),
                  const Text(
                    "Nombre de skins :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(summaries!.toString(),
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ),
          );
  }
}
