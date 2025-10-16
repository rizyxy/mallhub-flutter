import 'package:flutter/material.dart';

class StoreSearchBar extends StatelessWidget {
  const StoreSearchBar({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: textEditingController,
        style: const TextStyle(fontSize: 15),
        decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            hintText: "Search stores...",
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
