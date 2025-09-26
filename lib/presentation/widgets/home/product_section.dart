import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:mallhub_flutter/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:mallhub_flutter/presentation/screens/product_page.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_catalog.dart';
import 'package:mallhub_flutter/presentation/widgets/shared/item_card.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({
    super.key,
  });

  @override
  State<ProductSection> createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  @override
  void didChangeDependencies() {
    context.read<ProductBloc>().add(FetchProduct());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Product",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductPage()));
                },
                child: Text("View More"))
          ],
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
            return ProductCatalog(
              products: state.products.take(4).toList(),
            );
          }

          return Container();
        }),
      ],
    );
  }
}
