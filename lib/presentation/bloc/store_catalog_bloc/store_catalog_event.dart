part of 'store_catalog_bloc.dart';

sealed class StoreCatalogEvent extends Equatable {
  const StoreCatalogEvent();

  @override
  List<Object?> get props => [];
}

class FetchStoreCatalog extends StoreCatalogEvent {
  final int storeId;

  const FetchStoreCatalog({required this.storeId});

  @override
  List<Object?> get props => [storeId];
}

class FetchMoreStoreCatalog extends StoreCatalogEvent {
  final int storeId;

  const FetchMoreStoreCatalog({required this.storeId});

  @override
  List<Object?> get props => [storeId];
}
