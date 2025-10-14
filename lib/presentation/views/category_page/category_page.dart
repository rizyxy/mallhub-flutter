import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/category/category_bloc_consumer.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

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
              "All Categories",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocProvider<CategoryBloc>(
                create: (context) => CategoryBloc()..add(FetchCategory()),
                child: const CategoryBlocConsumer(),
              ),
            )
          ],
        ),
      )),
    );
  }
}
