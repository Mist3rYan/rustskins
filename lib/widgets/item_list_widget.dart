import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rustskins/models/item.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: item.image,
              placeholder: (context, url) => const CircularProgressIndicator(
                color: Color(0xFFbf8700),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            Text(
              item.name,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              "${item.price} €",
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
