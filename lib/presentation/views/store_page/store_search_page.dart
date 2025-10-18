import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/bloc/store_search_bloc/store_search_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_search_bar.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_search_bloc_consumer.dart';
import 'package:mallhub_flutter/utils/debouncer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreSearchPage extends StatefulWidget {
  const StoreSearchPage({super.key});

  @override
  State<StoreSearchPage> createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  final TextEditingController _textEditingController = TextEditingController();

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      _debouncer.run(() {
        if (_textEditingController.value.text == "") {
          context.read<StoreSearchBloc>().add(ClearSearchedStore());
        } else {
          context.read<StoreSearchBloc>().add(FetchSearchedStore(
              searchQuery: _textEditingController.value.text));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Search Stores",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            StoreSearchBar(
              textEditingController: _textEditingController,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: StoreSearchBlocConsumer(
              textEditingController: _textEditingController,
            ))
          ],
        ),
      )),
    );
  }
}
