part of 'store_catalog_bloc.dart';

sealed class StoreCatalogState extends Equatable {
  const StoreCatalogState();

  @override
  List<Object?> get props => [];
}

class StoreCatalogInitial extends StoreCatalogState {}

abstract class StoreCatalogInitialLoadPassed extends StoreCatalogState {
  final ProductPaginated productPaginated;

  const StoreCatalogInitialLoadPassed({required this.productPaginated});

  @override
  List<Object?> get props => [productPaginated];
}

class StoreCatalogLoading extends StoreCatalogState {}

class StoreCatalogLoadingMore extends StoreCatalogInitialLoadPassed {
  const StoreCatalogLoadingMore({required super.productPaginated});
}

class StoreCatalogSuccess extends StoreCatalogInitialLoadPassed {
  const StoreCatalogSuccess({required super.productPaginated});
}

class StoreCatalogError extends StoreCatalogState {
  final String? errorMessage;

  const StoreCatalogError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class StoreCatalogErrorLoadingMore extends StoreCatalogInitialLoadPassed {
  final String? errorMessage;

  const StoreCatalogErrorLoadingMore(
      {required super.productPaginated, this.errorMessage});

  @override
  List<Object?> get props => [...super.props, errorMessage];
}
