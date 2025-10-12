import 'package:flutter/material.dart';

class ItemPill extends StatelessWidget {
  const ItemPill({super.key, required this.itemName});

  final String itemName;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(15)),
      child: Text(
        itemName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
