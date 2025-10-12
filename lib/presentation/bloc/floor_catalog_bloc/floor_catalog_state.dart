part of 'floor_catalog_bloc.dart';

sealed class FloorCatalogState extends Equatable {
  const FloorCatalogState();

  @override
  List<Object?> get props => [];
}

sealed class FloorCatalogInitialLoadPassed extends FloorCatalogState {
  final StorePaginated storePaginated;

  const FloorCatalogInitialLoadPassed({required this.storePaginated});

  @override
  List<Object?> get props => [storePaginated];
}

class FloorCatalogInitial extends FloorCatalogState {}

class FloorCatalogLoading extends FloorCatalogState {}

class FloorCatalogLoadingMore extends FloorCatalogInitialLoadPassed {
  const FloorCatalogLoadingMore({required super.storePaginated});
}

class FloorCatalogSuccess extends FloorCatalogInitialLoadPassed {
  const FloorCatalogSuccess({required super.storePaginated});
}

class FloorCatalogError extends FloorCatalogState {}

class FloorCatalogErrorLoadingMore extends FloorCatalogInitialLoadPassed {
  const FloorCatalogErrorLoadingMore({required super.storePaginated});
}
