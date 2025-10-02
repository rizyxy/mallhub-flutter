import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class StoreGrid extends StatelessWidget {
  const StoreGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.7),
      children: <Widget>[
        ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
        ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
      ],
    );
  }
}
