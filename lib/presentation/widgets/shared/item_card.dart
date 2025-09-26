import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.itemName,
      required this.itemInfo,
      this.itemImage});

  final String itemName;
  final String itemInfo;
  final String? itemImage;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Image.network(
            itemImage ?? "",
            fit: BoxFit.cover,
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            itemName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            itemInfo,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
