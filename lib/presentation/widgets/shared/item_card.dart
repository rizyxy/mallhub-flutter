import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key, required this.itemName, required this.itemDescription});

  final String itemName;
  final String itemDescription;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Container(
            color: Colors.grey.shade200,
          )),
          const SizedBox(
            height: 10,
          ),
          Text(
            itemName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(itemDescription)
        ],
      ),
    );
  }
}
