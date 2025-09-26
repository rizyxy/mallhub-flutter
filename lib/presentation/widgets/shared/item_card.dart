import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: Container(
            color: Colors.grey.shade200,
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            "Linen Shirt",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Rp 200.000",
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
