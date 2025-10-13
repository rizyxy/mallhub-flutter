import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:mallhub_flutter/presentation/views/subcategory_page.dart';

class CategoryBlocConsumer extends StatelessWidget {
  const CategoryBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is CategoryError) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    context.read<CategoryBloc>().add(FetchCategory());
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

          if (state is CategorySuccess) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubCategoryPage(
                                  category: state.categories[index])));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(state.categories[index].name),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: state.categories.length);
          }

          return SizedBox.shrink();
        });
  }
}
