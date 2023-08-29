import 'package:flutter/material.dart';
import 'package:rustskins/models/item.dart';
import 'package:rustskins/widgets/app_bar_widget.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key,required this.item});
  static const pageName = '/item';
  final Item item;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.image),
            Text(item.name),
            Text(item.price),
            Text(item.description),
          ],
        ),
      ),
    );
  }
}