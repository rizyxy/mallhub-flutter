import 'package:flutter/material.dart';
import 'package:mallhub_flutter/data/model/subcategory.dart';
import 'package:mallhub_flutter/presentation/widgets/sub_category/sub_category_catalog_bloc_consumer.dart';

class SubCategoryCatalogPage extends StatelessWidget {
  const SubCategoryCatalogPage({super.key, required this.subCategory});

  final SubCategoryModel subCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              subCategory.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: SubCategoryCatalogBlocConsumer(subCategory: subCategory))
          ],
        ),
      )),
    );
  }
}
