part of 'sub_category_bloc.dart';

sealed class SubCategoryEvent extends Equatable {
  const SubCategoryEvent();

  @override
  List<Object?> get props => [];
}

class FetchSubCategory extends SubCategoryEvent {
  final int categoryId;

  const FetchSubCategory({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
