part of 'product_search_bloc.dart';

sealed class ProductSearchState extends Equatable {
  const ProductSearchState();

  @override
  List<Object?> get props => [];
}

class ProductSearchInitial extends ProductSearchState {}

abstract class ProductSearchInitialLoadPassed extends ProductSearchState {
  final ProductPaginated productPaginated;

  const ProductSearchInitialLoadPassed({required this.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}

class ProductSearchLoading extends ProductSearchState {}

class ProductSearchLoadingMore extends ProductSearchInitialLoadPassed {
  const ProductSearchLoadingMore({required super.productPaginated});
}

class ProductSearchSuccess extends ProductSearchInitialLoadPassed {
  const ProductSearchSuccess({required super.productPaginated});
}

class ProductSearchError extends ProductSearchState {
  final String? errorMessage;

  const ProductSearchError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ProductSearchErrorLoadingMore extends ProductSearchInitialLoadPassed {
  final String? errorMessage;

  const ProductSearchErrorLoadingMore(
      {required super.productPaginated, this.errorMessage});

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
