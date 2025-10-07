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

class ProductLoadingMore extends ProductInitialLoadPassed {
  const ProductLoadingMore({required super.productPaginated});
}

class ProductSuccess extends ProductInitialLoadPassed {
  const ProductSuccess({required super.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}

class ProductError extends ProductState {
  final String? errorMessage;

  const ProductError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ProductErrorLoadingMore extends ProductInitialLoadPassed {
  final String? errorMessage;
  const ProductErrorLoadingMore(
      {required super.productPaginated, this.errorMessage});

  @override
  List<Object?> get props => [productPaginated, errorMessage];
}
