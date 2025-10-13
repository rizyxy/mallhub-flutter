part of 'sub_category_bloc.dart';

sealed class SubCategoryState extends Equatable {
  const SubCategoryState();

  @override
  List<Object?> get props => [];
}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {}

class SubCategorySuccess extends SubCategoryState {
  final List<SubCategoryModel> subCategories;

  const SubCategorySuccess({required this.subCategories});

  @override
  List<Object?> get props => [subCategories];
}

class SubCategoryError extends SubCategoryState {
  final String? errorMessage;

  const SubCategoryError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
