import 'package:flutter/material.dart';
import 'package:mallhub_flutter/presentation/widgets/store/store_search_bar.dart';

class StoreSearchPage extends StatelessWidget {
  StoreSearchPage({super.key});

  final TextEditingController _textEditingController = TextEditingController();

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
              "Search Stores",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            StoreSearchBar(
              textEditingController: _textEditingController,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )),
    );
  }
}
