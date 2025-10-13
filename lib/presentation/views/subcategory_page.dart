import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mallhub_flutter/data/model/category.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              category.name,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )
          ],
        ),
      )),
    );
  }
}
