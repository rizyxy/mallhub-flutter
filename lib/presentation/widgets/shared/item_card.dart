import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.itemName,
      required this.itemDescription,
      this.itemThumbnail});

  final String? itemThumbnail;
  final String itemName;
  final String itemDescription;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
              child: itemThumbnail != null
                  ? Image.network(
                      itemThumbnail!,
                      errorBuilder: (context, child, stackTrace) {
                        return Placeholder();
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return Center(
                          child: CircularProgressIndicator(
                            // Optionally calculate the progress percentage
                            value: loadingProgress?.expectedTotalBytes != null
                                ? loadingProgress!.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                      headers: {'ngrok-skip-browser-warning': 'true'},
                    )
                  : Container(
                      color: Colors.grey.shade200,
                    )),
          const SizedBox(
            height: 10,
          ),
          Text(
            itemName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(itemDescription)
        ],
      ),
    );
  }
}
