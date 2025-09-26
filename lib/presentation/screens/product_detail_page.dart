import 'package:flutter/material.dart';
import 'package:mallhub_flutter/data/model/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 400,
                child: CarouselView(
                    itemExtent: double.infinity,
                    children: product.productImages!
                        .map(
                          (img) => Image.network(
                            img,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList()),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Rp ${product.price}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                product.name,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                product.storeName,
                style: TextStyle(
                    fontSize: 15, decoration: TextDecoration.underline),
              ),
              SizedBox(
                height: 20,
              ),
              Text(product.description ?? "Product has no description")
            ],
          ),
        ),
      )),
    );
  }
}
