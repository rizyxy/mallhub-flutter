import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/store.dart';
import 'package:mallhub_flutter/presentation/bloc/store_catalog_bloc/store_catalog_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_grid.dart';

class StoreCatalogBlocConsumer extends StatelessWidget {
  const StoreCatalogBlocConsumer({super.key, required this.storeModel});

  final StoreModel storeModel;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreCatalogBloc, StoreCatalogState>(
        listener: (context, state) {
      if (state is StoreCatalogError || state is StoreCatalogErrorLoadingMore) {
        String? errorMessage;

        if (state is StoreCatalogError) {
          errorMessage = state.errorMessage;
        } else if (state is StoreCatalogErrorLoadingMore) {
          errorMessage = state.errorMessage;
        }

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage ?? "An error has occured")));
      }
    }, builder: (context, state) {
      if (state is StoreCatalogLoading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (state is StoreCatalogError) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                context
                    .read<StoreCatalogBloc>()
                    .add(FetchStoreCatalog(storeId: storeModel.id));
              },
              child: const Icon(
                Icons.restart_alt,
                size: 30,
              ),
            ),
            const Text("Tap to retry")
          ],
        );
      }

      if (state is StoreCatalogErrorLoadingMore) {
        return ProductGrid(
            key: const PageStorageKey<String>('storeCatalogGridScrollPosition'),
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
            products: state.productPaginated.data);
      }

      if (state is StoreCatalogLoadingMore) {
        return ProductGrid(
            key: const PageStorageKey<String>('storeCatalogGridScrollPosition'),
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
            products: state.productPaginated.data);
      }

      if (state is StoreCatalogSuccess) {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent) {
              if (state.productPaginated.nextCursor != null) {
                context
                    .read<StoreCatalogBloc>()
                    .add(FetchMoreStoreCatalog(storeId: storeModel.id));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No more products to show")));
              }

              return true;
            }

            return false;
          },
          child: ProductGrid(
              key: const PageStorageKey<String>(
                  'storeCatalogGridScrollPosition'),
              isLoadingMore: false,
              isErrorOnLoadingMore: false,
              products: state.productPaginated.data),
        );
      }

      return const SizedBox.shrink();
    });
  }
}
