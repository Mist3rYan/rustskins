//https://steamcommunity.com/profiles/76561197994719101/inventory/#252490
//https://api.steampowered.com/IInventoryService/GetInventory/v1/?appid=252490&steamid=76561197994719101&key=8EBAEF7DA5E71DA6D942BA6E26D26A00&format=xml
//https://steamcommunity.com/inventory/76561197994719101/252490/2  Page de l'inventaire
//https://steamcommunity.com/market/listings/252490/*****  Page de l'item sur le store "market_name" pour acceder à la page
// https://community.akamai.steamstatic.com/economy/image/*****  Pour les images "icon_url" ou "icon_url_large" pour les images

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rustskins/screens/item_list_screen.dart';
import 'package:rustskins/widgets/app_bar_widget.dart';
import '../services/steam_login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const pageName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // //ICI LES VARIABLES ET METHODES
  Future<Map<String, dynamic>>? _dataFuture; // Utiliser un Future nullable
  //Map<String, dynamic>? summaries;
  var apikey = '8EBAEF7DA5E71DA6D942BA6E26D26A00';
  //pasyan
  var playerId = "76561197994719101";
  //spycom
  //var playerId = "76561199253595436";

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData(); // Initialiser le Future dans initState
  }

  Future<Map<String, dynamic>> fetchData() async {
    //summaries = await getPlayerSummaries(playerId, apikey);
    final response = await http.get(
        Uri.parse('https://steamcommunity.com/inventory/$playerId/252490/2'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Votre inventaire doit être public');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBarWidget(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final jsonData = snapshot.data!;
            final totalInventoryCount = jsonData['total_inventory_count'];

            List<dynamic> assets = jsonData["assets"];
            List<dynamic> descriptions = jsonData["descriptions"];
            List<String> classids = [];
            List<String> assetids = [];
            List<String> marketNames = [];
            List<String> imageUrls = [];

            for (var asset in assets) {
              String classid = asset["classid"];
              String assetId = asset["assetid"];
              classids.add(classid);
              assetids.add(assetId);
            }
            for (var description in descriptions) {
              String marketName = description["market_name"];
              String imageUrl = description["icon_url"];
              marketNames.add(marketName);
              imageUrls.add(imageUrl);
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // CachedNetworkImage(
                  //   imageUrl: summaries!['avatarfull'],
                  //   placeholder: (context, url) =>
                  //       const CircularProgressIndicator(
                  //     color: Color(0xFFbf8700),
                  //   ),
                  //   errorWidget: (context, url, error) =>
                  //       const Icon(Icons.error),
                  // ),
                  Column(
                    children: [
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
                            // Text(
                            //   summaries!['personaname'],
                            //   style: const TextStyle(
                            //     fontSize: 30,
                            //     color: Colors.white,
                            //     fontFamily: 'Rust',
                            //   ),
                            // ),
                          ]),
                      Text(
                        "Votre inventaire contient $totalInventoryCount items.",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        color: const Color(0xFFbf8700),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              ItemListScreen.pageName,
                              arguments: {
                                'marketNames': marketNames,
                                'imageUrls': imageUrls,
                              },
                            );
                          },
                          child: const Text(
                            "Voir mes items",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'Rust',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Aucune donnée disponible.'));
          }
        },
      ),
    );
  }
}
