import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/views/product_page/product_detail_page.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid(
      {super.key,
      required this.isLoadingMore,
      required this.isErrorOnLoadingMore,
      required this.products});

  final bool isLoadingMore;
  final bool isErrorOnLoadingMore;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    int itemCount = products.length;

    if (isLoadingMore) {
      itemCount = itemCount + 2;
    } else if (isErrorOnLoadingMore) {
      itemCount = itemCount + 1;
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.7),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoadingMore && index >= products.length) {
          return const Center(child: CircularProgressIndicator());
        }

        if (isErrorOnLoadingMore && index >= products.length) {
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

        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailPage(productModel: products[index])));
          },
          child: ItemCard(
              itemThumbnail:
                  "${dotenv.get('SERVER_STORAGE')}/${products[index].productImages[0]}",
              itemName: products[index].name,
              itemDescription: products[index].store.name),
        );
      },
    );
  }
}
