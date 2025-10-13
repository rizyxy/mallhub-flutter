import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/category.dart';
import 'package:mallhub_flutter/presentation/bloc/sub_category_bloc/sub_category_bloc.dart';

class SubCategoryBlocConsumer extends StatelessWidget {
  const SubCategoryBlocConsumer({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCategoryBloc, SubCategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SubCategoryLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(30),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is SubCategoryError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  context
                      .read<SubCategoryBloc>()
                      .add(FetchSubCategory(categoryId: category.id));
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

        if (state is SubCategorySuccess) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(state.subCategories[index].name),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: state.subCategories.length);
        }

        return SizedBox.shrink();
      },
    );
  }
}
