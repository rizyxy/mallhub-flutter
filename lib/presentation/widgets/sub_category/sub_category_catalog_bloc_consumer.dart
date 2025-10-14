import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/sub_category.dart';
import 'package:mallhub_flutter/presentation/bloc/sub_category_catalog_bloc/sub_category_catalog_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_grid.dart';

class SubCategoryCatalogBlocConsumer extends StatelessWidget {
  const SubCategoryCatalogBlocConsumer({super.key, required this.subCategory});

  final SubCategoryModel subCategory;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCategoryCatalogBloc, SubCategoryCatalogState>(
      listener: (context, state) {
        if (state is SubCategoryCatalogError ||
            state is SubCategoryCatalogErrorLoadingMore) {
          String? errorMessage;

          if (state is SubCategoryCatalogError) {
            errorMessage = state.errorMessage;
          } else if (state is SubCategoryCatalogErrorLoadingMore) {
            errorMessage = state.errorMessage;
          }

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage ?? "An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is SubCategoryCatalogLoading) {
          return const Center(
              child: Padding(
            padding: EdgeInsets.all(30),
            child: CircularProgressIndicator(),
          ));
        }

        if (state is SubCategoryCatalogError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context.read<SubCategoryCatalogBloc>().add(
                      FetchSubCategoryCatalog(subCategoryId: subCategory.id));
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

        if (state is SubCategoryCatalogLoadingMore) {
          return ProductGrid(
            key: PageStorageKey<String>('subCategoryCatalogScrollPosition'),
            isLoadingMore: true,
            isErrorOnLoadingMore: false,
            products: state.productPaginated.data,
          );
        }

        if (state is SubCategoryCatalogErrorLoadingMore) {
          return ProductGrid(
            key: PageStorageKey<String>('subCategoryCatalogScrollPosition'),
            isLoadingMore: false,
            isErrorOnLoadingMore: true,
            products: state.productPaginated.data,
          );
        }

        if (state is SubCategoryCatalogSuccess) {
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent) {
                if (state.productPaginated.nextCursor != null) {
                  context.read<SubCategoryCatalogBloc>().add(
                      FetchMoreSubCategoryCatalog(
                          subCategoryId: subCategory.id));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("No more products to show")));
                }

                return true;
              }

              return false;
            },
            child: ProductGrid(
              key: PageStorageKey<String>('subCategoryCatalogScrollPosition'),
              isLoadingMore: false,
              isErrorOnLoadingMore: false,
              products: state.productPaginated.data,
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
