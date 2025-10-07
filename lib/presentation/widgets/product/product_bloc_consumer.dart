import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_grid.dart';

class ProductBlocConsumer extends StatelessWidget {
  const ProductBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError || state is ProductErrorLoadingMore) {
          String? errorMessage;

          if (state is ProductError) {
            errorMessage = state.errorMessage;
          } else if (state is ProductErrorLoadingMore) {
            errorMessage = state.errorMessage;
          }

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage ?? "An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ));
        }

        if (state is ProductError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<ProductBloc>().add(FetchProduct());
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

        if (state is ProductLoadingMore) {
          return ProductGrid(
            key: const PageStorageKey<String>('productGridScrollPosition'),
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
            products: state.productPaginated.data,
          );
        }

        if (state is ProductErrorLoadingMore) {
          return ProductGrid(
            key: const PageStorageKey<String>('productGridScrollPosition'),
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
            products: state.productPaginated.data,
          );
        }

        if (state is ProductSuccess) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                if (state.productPaginated.nextCursor != null) {
                  context.read<ProductBloc>().add(FetchMoreProduct());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No more store to show")));
                }

                return true;
              }

              return false;
            },
            child: ProductGrid(
              key: const PageStorageKey<String>('productGridScrollPosition'),
              isLoadingMore: false,
              isErrorOnLoadingMore: false,
              products: state.productPaginated.data,
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
