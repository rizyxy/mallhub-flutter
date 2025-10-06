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
        if (state is ProductError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("An error has occured")));
        }
      },
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(30),
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

        if (state is ProductSuccess) {
          return ProductGrid();
        }

        return SizedBox.shrink();
      },
    );
  }
}
