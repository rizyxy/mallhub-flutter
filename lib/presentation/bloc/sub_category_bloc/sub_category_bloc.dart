import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/sub_category.dart';
import 'package:mallhub_flutter/data/repository/sub_category_repository.dart';

part 'sub_category_event.dart';
part 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final SubCategoryRepository _subCategoryRepository = SubCategoryRepository();

  SubCategoryBloc() : super(SubCategoryInitial()) {
    on<FetchSubCategory>((event, emit) async {
      emit(SubCategoryLoading());

      try {
        List<SubCategoryModel> subCategories = await _subCategoryRepository
            .fetchSubCategory(categoryId: event.categoryId);

        emit(SubCategorySuccess(subCategories: subCategories));
      } catch (e) {
        emit(SubCategoryError(errorMessage: e.toString()));
      }
    });
  }
}
