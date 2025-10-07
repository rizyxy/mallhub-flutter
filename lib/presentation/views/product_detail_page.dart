import 'package:flutter/material.dart';
import 'package:mallhub_flutter/data/model/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 400,
                color: Colors.grey.shade200,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                productModel.name,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "Rp ${productModel.price.toString()}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                productModel.storeName,
                style: const TextStyle(
                    decoration: TextDecoration.underline, fontSize: 15),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(productModel.description)
            ],
          ),
        ),
      )),
    );
  }
}
