import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid(
      {super.key,
      required this.isLoadingMore,
      required this.isErrorOnLoadingMore});

  final bool isLoadingMore;
  final bool isErrorOnLoadingMore;

  @override
  Widget build(BuildContext context) {
    int itemCount = 10;

    if (isLoadingMore) {
      itemCount = itemCount + 2;
    } else if (isErrorOnLoadingMore) {
      itemCount = itemCount + 1;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoadingMore && index >= 10) {
          return const Center(child: CircularProgressIndicator());
        }

        if (isErrorOnLoadingMore && index >= 10) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    context.read<ProductBloc>().add(FetchMoreProduct());
                  },
                  child: const Icon(
                    Icons.restart_alt,
                  )),
              const Text("Tap to retry")
            ],
          );
        }

        return ItemCard(
            itemName: "Linen Shirt", itemDescription: "Pull and Bear");
      },
    );
  }
}
