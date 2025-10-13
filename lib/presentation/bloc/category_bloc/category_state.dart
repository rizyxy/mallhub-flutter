part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryModel> categories;

  const CategorySuccess({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String? errorMessage;

  const CategoryError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
