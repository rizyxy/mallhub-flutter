part of 'sub_category_catalog_bloc.dart';

sealed class SubCategoryCatalogState extends Equatable {
  const SubCategoryCatalogState();

  @override
  List<Object?> get props => [];
}

class SubCategoryCatalogInitial extends SubCategoryCatalogState {}

abstract class SubCategoryCatalogInitialLoadPassed
    extends SubCategoryCatalogState {
  final ProductPaginated productPaginated;

  const SubCategoryCatalogInitialLoadPassed({required this.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}

class SubCategoryCatalogLoading extends SubCategoryCatalogState {}

class SubCategoryCatalogLoadingMore
    extends SubCategoryCatalogInitialLoadPassed {
  const SubCategoryCatalogLoadingMore({required super.productPaginated});
}

class SubCategoryCatalogSuccess extends SubCategoryCatalogInitialLoadPassed {
  const SubCategoryCatalogSuccess({required super.productPaginated});
}

class SubCategoryCatalogError extends SubCategoryCatalogState {
  final String? errorMessage;

  const SubCategoryCatalogError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class SubCategoryCatalogErrorLoadingMore
    extends SubCategoryCatalogInitialLoadPassed {
  final String? errorMessage;

  const SubCategoryCatalogErrorLoadingMore(
      {required super.productPaginated, this.errorMessage});

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
