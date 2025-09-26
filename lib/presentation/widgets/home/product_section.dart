import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Product",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("View More")
          ],
        ),
        SizedBox(
          height: 20,
        ),
        GridView(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.7),
          children: <Widget>[ItemCard(), ItemCard(), ItemCard(), ItemCard()],
        )
      ],
    );
  }
}
