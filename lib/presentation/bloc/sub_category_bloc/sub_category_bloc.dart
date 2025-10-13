import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/subcategory.dart';

part 'sub_category_event.dart';
part 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  SubCategoryBloc() : super(SubCategoryInitial()) {
    on<FetchSubCategory>((event, emit) async {
      emit(SubCategoryLoading());

      try {
        await Future.delayed(Duration(seconds: 2));

        emit(SubCategorySuccess(subCategories: []));
      } catch (e) {
        emit(SubCategoryError(errorMessage: e.toString()));
      }
    });
  }
}
