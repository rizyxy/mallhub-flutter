import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7),
      children: <Widget>[
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
        ItemCard(itemName: "Linen Shirt", itemDescription: "Pull and Bear"),
      ],
    );
  }
}
