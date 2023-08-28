import 'package:rustskins/widgets/item_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:rustskins/widgets/app_bar_widget.dart';

import '../models/item.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  static const pageName = '/item_list';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<String> marketNames = args['marketNames'] as List<String>;
    final List<String> imageUrls = args['imageUrls'] as List<String>;
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            Container(
              color: const Color(0xFFbf8700),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Inventaire',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rust',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: marketNames.length,
                itemBuilder: (context, index) {
                  return ItemListWidget(
                    item: Item(
                        marketNames[index],
                        'https://community.akamai.steamstatic.com/economy/image/${imageUrls[index]}',
                        'price',
                        'steamId',
                        'description'),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
