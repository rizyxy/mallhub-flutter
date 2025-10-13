import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/views/category_page.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_bloc_consumer.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "All Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(10),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: const Text("Search Product"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryPage()));
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Ink(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.filter_alt),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(child: ProductBlocConsumer())
          ],
        ),
      )),
    );
  }
}
