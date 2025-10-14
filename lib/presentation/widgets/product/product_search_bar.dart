import 'package:flutter/material.dart';
import 'package:mallhub_flutter/utils/debouncer.dart';

class ProductSearchBar extends StatelessWidget {
  ProductSearchBar({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: textEditingController,
        style: TextStyle(fontSize: 15),
        decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            hintText: "Search products...",
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
