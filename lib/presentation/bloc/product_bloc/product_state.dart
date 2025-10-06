part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

abstract class ProductInitialLoadPassed extends ProductState {
  final ProductPaginated productPaginated;

  const ProductInitialLoadPassed({required this.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}

class ProductLoading extends ProductState {}

class ProductLoadingMore extends ProductState {
  final List<ProductModel> products;

  const ProductLoadingMore({required this.products});

  @override
  List<Object?> get props => [products];
}

class ProductSuccess extends ProductInitialLoadPassed {
  ProductSuccess({required super.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}

class ProductError extends ProductState {
  final String? errorMessage;

  const ProductError({this.errorMessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class ProductErrorLoadingMore extends ProductInitialLoadPassed {
  ProductErrorLoadingMore({required super.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}
