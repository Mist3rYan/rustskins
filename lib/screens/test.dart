//https://steamcommunity.com/profiles/76561197994719101/inventory/#252490
//https://api.steampowered.com/IInventoryService/GetInventory/v1/?appid=252490&steamid=76561197994719101&key=8EBAEF7DA5E71DA6D942BA6E26D26A00&format=xml
//https://steamcommunity.com/inventory/76561197994719101/252490/2  Page de l'inventaire
//https://steamcommunity.com/market/listings/252490/*****  Page de l'item sur le store "market_name" pour acceder à la page
// https://community.akamai.steamstatic.com/economy/image/*****  Pour les images "icon_url" ou "icon_url_large" pour les images
//  var playerId = "76561197994719101"; pasyan
//https://steamcommunity.com/market/priceoverview/?appid=252490&currency=3&market_hash_name=Caution%20Crate
//'https://steamcommunity.com/market/priceoverview/?appid=252490&currency=3&market_hash_name=${marketNames[index]}',

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/steam_login.dart';
import '../widgets/app_bar_widget.dart';
import '../configs/config.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  static const pageName = "/test";

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final apikey = ConfigApp.apiKey;
  Map<String, dynamic>? summaries;
  Map<String, dynamic> jsonData = {};
  String steamId = '';
  String iconeUrl = '';
  String pseudo = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    iconeUrl = prefs.getString('iconeUrl') ?? '';
    pseudo = prefs.getString('pseudo') ?? '';
    steamId = prefs.getString('steamId') ?? '';
  }

  Future<void> fetchData() async {
    await loadData();
    summaries = await getPlayerSummaries(steamId, apikey);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
            appBar: AppBarWidget(context),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CachedNetworkImage(
                    imageUrl: summaries!['avatarfull'],
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: Color(0xFFbf8700),
                    ),
                  ),
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
                ],
              ),
            ),
          );
  }
}
