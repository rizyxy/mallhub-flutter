import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_search_bar.dart';

class ProductSearchPage extends StatelessWidget {
  const ProductSearchPage({super.key});

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
              "Search Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ProductSearchBar()
          ],
        ),
      )),
    );
  }
}
