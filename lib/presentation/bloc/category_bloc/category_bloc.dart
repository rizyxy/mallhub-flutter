import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mallhub_flutter/data/model/category.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<FetchCategory>((event, emit) async {
      emit(CategoryLoading());

      try {
        await Future.delayed(Duration(seconds: 2));

        emit(CategorySuccess(categories: []));
      } catch (e) {
        emit(CategoryError(errorMessage: e.toString()));
      }
    });
  }
}
