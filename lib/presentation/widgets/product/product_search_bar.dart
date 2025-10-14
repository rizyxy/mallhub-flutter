import 'package:flutter/material.dart';
import 'package:mallhub_flutter/utils/debouncer.dart';

class ProductSearchBar extends StatelessWidget {
  ProductSearchBar({
    super.key,
  });

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        onChanged: (value) {
          _debouncer.run(() {
            print("Searching for $value");
          });
        },
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
