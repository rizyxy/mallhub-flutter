import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/store_paginated.dart';
import 'package:mallhub_flutter/data/repository/floor_repository.dart';

part 'floor_catalog_event.dart';
part 'floor_catalog_state.dart';

class FloorCatalogBloc extends Bloc<FloorCatalogEvent, FloorCatalogState> {
  FloorRepository _floorRepository = FloorRepository();

  FloorCatalogBloc() : super(FloorCatalogInitial()) {
    on<FetchFloorCatalog>((event, emit) async {
      emit(FloorCatalogLoading());

      try {
        StorePaginated storePaginated =
            await _floorRepository.fetchFloorCatalog(floorId: event.floorId);

        emit(FloorCatalogSuccess(storePaginated: storePaginated));
      } catch (e) {
        emit(FloorCatalogError());
      }
    });

    on<FetchMoreFloorCatalog>((event, emit) async {
      if (!(state is FloorCatalogSuccess ||
          state is FloorCatalogErrorLoadingMore)) {
        return;
      }

      FloorCatalogInitialLoadPassed prevState =
          state as FloorCatalogInitialLoadPassed;

      StorePaginated prevStorePaginated = prevState.storePaginated;

      emit(FloorCatalogLoadingMore(storePaginated: prevStorePaginated));

      try {
        StorePaginated newStorePaginated =
            await _floorRepository.fetchFloorCatalog(floorId: event.floorId);

        StorePaginated updatedStorePaginated = StorePaginated(data: [
          ...prevStorePaginated.data,
          ...newStorePaginated.data,
        ], nextCursor: newStorePaginated.nextCursor);

        emit(FloorCatalogSuccess(storePaginated: updatedStorePaginated));
      } catch (e) {
        emit(FloorCatalogErrorLoadingMore(storePaginated: prevStorePaginated));
      }
    });
  }
}
