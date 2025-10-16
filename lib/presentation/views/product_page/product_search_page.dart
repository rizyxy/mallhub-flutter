import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/product_search_bloc/product_search_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_search_bar.dart';
import 'package:mallhub_flutter/presentation/widgets/product/product_search_bloc_consumer.dart';
import 'package:mallhub_flutter/utils/debouncer.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  final TextEditingController _textEditingController = TextEditingController();

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      _debouncer.run(() {
        if (_textEditingController.value.text == "") {
          context.read<ProductSearchBloc>().add(ClearSearchedProduct());
        } else {
          context.read<ProductSearchBloc>().add(FetchSearchedProduct(
              searchQuery: _textEditingController.value.text));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Search Products",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ProductSearchBar(
              textEditingController: _textEditingController,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ProductSearchBlocConsumer(
                textEditingController: _textEditingController,
              ),
            )
          ],
        ),
      )),
    );
  }
}
