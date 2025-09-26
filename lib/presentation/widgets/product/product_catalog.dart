import 'package:flutter/material.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:mallhub_flutter/presentation/screens/product_detail_page.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class ProductCatalog extends StatelessWidget {
  const ProductCatalog({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.7),
        children: products
            .map((product) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: product)));
                  },
                  child: ItemCard(
                    itemName: product.name,
                    itemInfo: "Rp ${product.price}",
                    itemImage: product.productImages?.first,
                  ),
                ))
            .toList());
  }
}
