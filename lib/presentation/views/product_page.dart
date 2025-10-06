import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_bloc_consumer.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_grid.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

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
              "All Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: ProductBlocConsumer())
          ],
        ),
      )),
    );
  }
}
