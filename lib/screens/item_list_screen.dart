import 'package:rustskins/widgets/item_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:rustskins/widgets/app_bar_widget.dart';

import '../models/item.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  static const pageName = '/item_list';

  @override
  Widget build(BuildContext context) {
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
              child: ListView(
                children: [
                  ItemListWidget(
                    item: Item(
                        'name',
                        'https://rustlabs.com/img/skins/324/14187.png',
                        'price',
                        'steamId',
                        'description'),
                  ),
                  ItemListWidget(
                    item: Item(
                        'name',
                        'https://rustlabs.com/img/skins/324/14187.png',
                        'price',
                        'steamId',
                        'description'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
