import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_catalog.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "All Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is ProductSuccess) {
                return ProductCatalog(products: state.products);
              }

              return Container();
            })
          ],
        ),
      )),
    );
  }
}
