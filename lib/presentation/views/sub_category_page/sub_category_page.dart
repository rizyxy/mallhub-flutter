import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/category.dart';
import 'package:mallhub_flutter/presentation/bloc/sub_category_bloc/sub_category_bloc.dart';
import 'package:mallhub_flutter/presentation/widgets/sub_category/sub_category_bloc_consumer.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key, required this.category});

  final CategoryModel category;

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
            Text(
              category.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocProvider<SubCategoryBloc>(
                  create: (context) => SubCategoryBloc()
                    ..add(FetchSubCategory(categoryId: category.id)),
                  child: SubCategoryBlocConsumer(category: category)),
            )
          ],
        ),
      )),
    );
  }
}
