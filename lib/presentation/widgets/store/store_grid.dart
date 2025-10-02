import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreGrid extends StatelessWidget {
  StoreGrid(
      {super.key,
      required this.isLoadingMore,
      required this.isErrorOnLoadingMore});

  final bool isLoadingMore;
  final bool isErrorOnLoadingMore;

  final List<ItemCard> itemCards = [
    ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Zara", itemDescription: "Lantai 1"),
    ItemCard(itemName: "Pull and Bear", itemDescription: "Lantai 1"),
  ];

  @override
  Widget build(BuildContext context) {
    int itemCount = itemCards.length;

    if (isLoadingMore) {
      itemCount = itemCount + 10;
    } else if (isErrorOnLoadingMore) {
      itemCount = itemCount + 1;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.7),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoadingMore && index >= itemCards.length) {
          return Center(child: CircularProgressIndicator());
        }

        if (isErrorOnLoadingMore && index >= itemCards.length) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    context.read<StoreBloc>().add(FetchMoreStore());
                  },
                  child: Icon(
                    Icons.restart_alt,
                  )),
              Text("Tap to retry")
            ],
          );
        }

        return itemCards[index];
      },
    );
  }
}
