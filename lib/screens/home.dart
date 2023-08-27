import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Pour décoder le JSON
import 'package:rustskins/services/steam_login.dart';
import 'package:cached_network_image/cached_network_image.dart';
//Navigator.pushNamed(context, Home.pageName,arguments: openId),
//8EBAEF7DA5E71DA6D942BA6E26D26A00
//https://steamcommunity.com/profiles/76561197994719101/inventory/#252490
//https://api.steampowered.com/IInventoryService/GetInventory/v1/?appid=252490&steamid=76561197994719101&key=8EBAEF7DA5E71DA6D942BA6E26D26A00&format=xml
//https://steamcommunity.com/inventory/76561197994719101/252490/2  Page de l'inventaire
//https://steamcommunity.com/market/listings/252490/*****  Page de l'item sur le store "market_name" pour acceder à la page
// https://community.akamai.steamstatic.com/economy/image/*****  Pour les images "icon_url" ou "icon_url_large" pour les images

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
  //var playerId = "76561199253595436"; //spycom
  var playerId = "76561197994719101"; //pasyan

  Map<String, dynamic> jsonData = {};
  int totalInventoryCount = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    summaries = await getPlayerSummaries(playerId, apikey);
    print('Summaries:');
    print(summaries!['avatarfull']);
    final response = await http.get(Uri.parse(
        'https://steamcommunity.com/inventory/76561197994719101/252490/2'));
    print('Reponse:');
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final totalInventory =
          decodedData['total_inventory_count']; // Récupérer la valeur de la clé
      setState(() {
        jsonData = decodedData;
        totalInventoryCount = totalInventory;
      });
    } else {
      throw Exception('Votre inventaire doit être public');
    }
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
                children: [
                  CachedNetworkImage(
                    imageUrl: summaries!['avatarfull'],
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: Color(0xFFbf8700),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bonjour ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'Rust',
                          ),
                        ),
/*                     Text(
                      summaries!['personaname'],
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Rust',
                      ),
                    ), */
                      ]),
                  Text(
                    "Votre inventaire contient $totalInventoryCount items.",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
/*                   Text(summaries!.toString(),
                      style: const TextStyle(color: Colors.white)), */
                ],
              ),
            ),
          );
  }
}
