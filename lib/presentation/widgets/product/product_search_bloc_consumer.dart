import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/product_search_bloc/product_search_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_grid.dart';

class ProductSearchBlocConsumer extends StatelessWidget {
  const ProductSearchBlocConsumer(
      {super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductSearchBloc, ProductSearchState>(
      listener: (context, state) {
        if (state is ProductSearchError ||
            state is ProductSearchErrorLoadingMore) {
          String? errorMessage;

          if (state is ProductSearchError) {
            errorMessage = state.errorMessage;
          } else if (state is ProductSearchErrorLoadingMore) {
            errorMessage = state.errorMessage;
          }

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage ?? "An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is ProductSearchLoading) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  height: 10,
                ),
                Text("Searching for ${textEditingController.value.text}")
              ],
            ),
          ));
        }

        if (state is ProductSearchLoadingMore) {
          return ProductGrid(
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
            products: state.productPaginated.data,
          );
        }

        if (state is ProductSearchError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<ProductSearchBloc>().add(FetchSearchedProduct(
                      searchQuery: textEditingController.value.text));
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

        if (state is ProductSearchErrorLoadingMore) {
          return ProductGrid(
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
            products: state.productPaginated.data,
          );
        }

        if (state is ProductSearchSuccess) {
          if (state.productPaginated.data.isNotEmpty) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent) {
                  if (state.productPaginated.nextCursor != null) {
                    context.read<ProductSearchBloc>().add(
                        FetchMoreSearchedProduct(
                            searchQuery: textEditingController.value.text));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("No more products to show")));
                  }

                  return true;
                }

                return false;
              },
              child: ProductGrid(
                isLoadingMore: false,
                isErrorOnLoadingMore: false,
                products: state.productPaginated.data,
              ),
            );
          } else {
            return const Center(
              child: Text("No matching products found"),
            );
          }
        }

        return const Center(
          child: Text("You haven't searched anything"),
        );
      },
    );
  }
}
