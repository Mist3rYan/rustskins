//https://steamcommunity.com/profiles/76561197994719101/inventory/#252490
//https://api.steampowered.com/IInventoryService/GetInventory/v1/?appid=252490&steamid=76561197994719101&key=8EBAEF7DA5E71DA6D942BA6E26D26A00&format=xml
//https://steamcommunity.com/inventory/76561197994719101/252490/2  Page de l'inventaire
//https://steamcommunity.com/market/listings/252490/*****  Page de l'item sur le store "market_name" pour acceder à la page
// https://community.akamai.steamstatic.com/economy/image/*****  Pour les images "icon_url" ou "icon_url_large" pour les images
//  var playerId = "76561197994719101"; pasyan
//https://steamcommunity.com/market/priceoverview/?appid=252490&currency=3&market_hash_name=Caution%20Crate
//'https://steamcommunity.com/market/priceoverview/?appid=252490&currency=3&market_hash_name=${marketNames[index]}',

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/steam_login.dart';
import '../widgets/app_bar_widget.dart';
import 'item_list_screen.dart';
import 'login.dart';
import '../configs/config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static const pageName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final apikey = ConfigApp.apiKey;
  Map<String, dynamic>? summaries;
  Map<String, dynamic> jsonData = {};
  int totalInventoryCount = 0;
  String pseudo = '';
  String iconeUrl = '';
  String steamId = '';
  List<String> marketNames = [];
  List<String> imageUrls = [];

  Future<void> saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('iconeUrl', iconeUrl);
    await prefs.setString('pseudo', pseudo);
    await prefs.setString('steamId', steamId);
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    iconeUrl = prefs.getString('iconeUrl') ?? '';
    pseudo = prefs.getString('pseudo') ?? '';
    steamId = prefs.getString('steamId') ?? '';
  }

  Future<void> resetJsonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('jsonData');
    setState(() {
      jsonData = {};
    });
    await fetchData();
  }

  Future<void> setJsonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jsonData', jsonEncode(jsonData));
  }

  Future<void> getJsonData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cachedJsonData = prefs.getString('jsonData') ?? '';
    if (cachedJsonData.isNotEmpty) {
      setState(() {
        jsonData = jsonDecode(cachedJsonData);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getJsonData();
    fetchData();
  }

  Future<void> fetchData() async {
    await loadData();
    if (steamId.isEmpty) {
      _redirectToLoginPage();
      return;
    }
    if (pseudo.isEmpty) {
      summaries = await getPlayerSummaries(steamId, apikey);
      setState(() {
        pseudo = summaries!['personaname'];
        iconeUrl = summaries!['avatarfull'];
      });
      saveData();
    }
    if (jsonData.isEmpty) {
      try {
        final response = await http.get(Uri.parse(
            'https://steamcommunity.com/inventory/$steamId/252490/2?l=french&count=5000'));
        if (response.statusCode == 200) {
          final decodedData = json.decode(response.body);
          final totalInventory = decodedData['total_inventory_count'];
          setState(() {
            jsonData = decodedData;
            totalInventoryCount = totalInventory;
            setJsonData();
          });
        } else {
          _handleErrorResponse(response.statusCode);
        }
      } catch (error) {
        _handleError(error);
      }
    } else {
      final totalInventory =
          jsonData['total_inventory_count']; // Récupérer la valeur de la clé
      setState(() {
        jsonData = jsonData;
        totalInventoryCount = totalInventory;
      });
    }
  }

  void _redirectToLoginPage() {
    Navigator.pushNamed(context, Login.pageName);
  }

  void _handleErrorResponse(int statusCode) {
    String errorMessage;
    switch (statusCode) {
      case 400:
        errorMessage =
            'Veuillez vérifier que tous les paramètres sont corrects';
        break;
      case 401:
        errorMessage = 'Accès refusé, veuillez réessayer plus tard';
        break;
      case 403:
        errorMessage = 'Votre inventaire doit être public';
        break;
      case 404:
        errorMessage = 'Page introuvable, veuillez réessayer plus tard';
        break;
      case 429:
        errorMessage = 'Trop de requêtes, veuillez réessayer plus tard';
        break;
      case 503:
        errorMessage = 'Service indisponible, veuillez réessayer plus tard';
        break;
      default:
        errorMessage = 'Erreur inconnue, veuillez réessayer plus tard';
    }
    _showErrorDialog(errorMessage);
  }

  void _handleError(dynamic error) {
    _showErrorDialog(
        'Une erreur s\'est produite. Veuillez réessayer plus tard.');
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Login.pageName);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (jsonData["descriptions"] != null) {
      List<dynamic> descriptions = jsonData["descriptions"];
      for (var description in descriptions) {
        String marketName = description["market_name"];
        String imageUrl = description["icon_url"];
        marketNames.add(marketName);
        imageUrls.add(imageUrl);
      }
    }
    return pseudo.isEmpty
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
                    imageUrl: iconeUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: Color(0xFFbf8700),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bonjour ",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'Rust',
                              ),
                            ),
                            Text(
                              pseudo,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'Rust',
                              ),
                            ),
                          ]),
                      Text(
                        "Votre inventaire contient $totalInventoryCount items.",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        color: ConfigApp.colors.accentColor,
                        child: TextButton(
                          onPressed: () {
                            resetJsonData();
                          },
                          child: const Text(
                            "Actualiser",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontFamily: 'Rust',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
