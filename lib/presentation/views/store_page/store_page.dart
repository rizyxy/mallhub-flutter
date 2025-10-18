import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/store_search_bloc/store_search_bloc.dart';
import 'package:mallhub_flutter/presentation/views/store_page/store_search_page.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_bloc_consumer.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

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
              "All Stores",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider<StoreSearchBloc>(
                            create: (context) => StoreSearchBloc(),
                            child: const StoreSearchPage())));
              },
              child: Ink(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("Search store"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(child: StoreBlocConsumer())
          ],
        ),
      )),
    );
  }
}
