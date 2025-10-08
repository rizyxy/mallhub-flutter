import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/store_bloc/store_bloc.dart';
import 'package:mallhub_flutter/presentation/views/product_detail_page.dart';
import 'package:mallhub_flutter/presentation/views/product_page.dart';
import 'package:mallhub_flutter/presentation/views/store_catalog_page.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                "MallHub",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    "Product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProductPage()));
                      },
                      child: const Text("View More"))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
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

                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProductInitialLoadPassed) {
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.7),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                        productModel: state
                                            .productPaginated.data[index])));
                          },
                          child: ItemCard(
                              itemName: state.productPaginated.data[index].name,
                              itemDescription: state
                                  .productPaginated.data[index].store.name),
                        );
                      });
                }

                return const SizedBox.shrink();
              }),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Store",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("View More")
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<StoreBloc, StoreState>(builder: (context, state) {
                if (state is StoreError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          context.read<StoreBloc>().add(FetchStore());
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

                if (state is StoreLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is StoreInitialLoadPassed) {
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              childAspectRatio: 0.7),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreCatalogPage(
                                        storeModel:
                                            state.storePaginated.data[index])));
                          },
                          child: ItemCard(
                              itemName: state.storePaginated.data[index].name,
                              itemDescription:
                                  state.storePaginated.data[index].floor.name),
                        );
                      });
                }

                return const SizedBox.shrink();
              })
            ],
          ),
        ),
      )),
    );
  }
}
