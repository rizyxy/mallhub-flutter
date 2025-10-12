part of 'floor_catalog_bloc.dart';

sealed class FloorCatalogEvent extends Equatable {
  const FloorCatalogEvent();

  @override
  List<Object?> get props => [];
}

class FetchFloorCatalog extends FloorCatalogEvent {
  final int floorId;

  const FetchFloorCatalog({required this.floorId});

  @override
  List<Object?> get props => [floorId];
}

class FetchMoreFloorCatalog extends FloorCatalogEvent {
  final int floorId;

  const FetchMoreFloorCatalog({required this.floorId});

  @override
  List<Object?> get props => [floorId];
}
