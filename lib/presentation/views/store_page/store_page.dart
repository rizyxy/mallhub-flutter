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
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "All Stores",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
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
                            child: StoreSearchPage())));
              },
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Text("Search store"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: StoreBlocConsumer())
          ],
        ),
      )),
    );
  }
}
