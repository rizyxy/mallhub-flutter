import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mallhub_flutter/data/model/category.dart';
import 'package:mallhub_flutter/data/repository/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository = CategoryRepository();

  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());

      try {
        List<CategoryModel> categories =
            await _categoryRepository.fetchCategory();

        emit(CategorySuccess(categories: categories));
      } catch (e) {
        emit(CategoryError(errorMessage: e.toString()));
      }
    });
  }
}
