import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);
  static const pageName = "/test";

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  Future<Map<String, dynamic>>? _dataFuture; // Utiliser un Future nullable

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchData(); // Initialiser le Future dans initState
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://steamcommunity.com/inventory/76561197994719101/252490/2'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Votre inventaire doit être public');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
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
            List<String> classids = [];
            for (var asset in assets) {
              String classid = asset["classid"];
              classids.add(classid);
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Votre inventaire contient $totalInventoryCount items.",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Classids: ${classids.join(', ')}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
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
