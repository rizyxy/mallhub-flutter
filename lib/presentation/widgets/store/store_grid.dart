import 'package:flutter/material.dart';
import 'package:mallhub_flutter/data/model/store.dart';
import 'package:mallhub_flutter/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:mallhub_flutter/presentation/views/store_page/store_catalog_page.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreGrid extends StatelessWidget {
  const StoreGrid(
      {super.key,
      required this.isLoadingMore,
      required this.isErrorOnLoadingMore,
      required this.stores});

  final bool isLoadingMore;
  final bool isErrorOnLoadingMore;
  final List<StoreModel> stores;

  @override
  Widget build(BuildContext context) {
    int itemCount = stores.length;

    if (isLoadingMore) {
      itemCount = itemCount + 2;
    } else if (isErrorOnLoadingMore) {
      itemCount = itemCount + 1;
    }

    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 0.7),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (isLoadingMore && index >= stores.length) {
          return const Center(child: CircularProgressIndicator());
        }

        if (isErrorOnLoadingMore && index >= stores.length) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    context.read<StoreBloc>().add(FetchMoreStore());
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
                        StoreCatalogPage(storeModel: stores[index])));
          },
          child: ItemCard(
              itemName: stores[index].name,
              itemDescription: stores[index].floor.name),
        );
      },
    );
  }
}
