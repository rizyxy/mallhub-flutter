import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/store.dart';
import 'package:mallhub_flutter/data/paginated/store_paginated.dart';
import 'package:mallhub_flutter/data/repository/store_repository.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository _storeRepository = StoreRepository();

  StoreBloc() : super(StoreInitial()) {
    on<FetchStore>((event, emit) async {
      emit(StoreLoading());

      try {
        StorePaginated storePaginated = await _storeRepository.fetchStore();

        emit(StoreSuccess(storePaginated: storePaginated));
      } catch (e) {
        emit(StoreError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreStore>((event, emit) async {
      if (!(state is StoreSuccess || state is StoreErrorLoadingMore)) {
        return;
      }

      StoreInitialLoadPassed prevState = state as StoreInitialLoadPassed;

      StorePaginated prevStorePaginatd = prevState.storePaginated;

      emit(StoreLoadingMore(stores: prevStorePaginatd.data));

      try {
        StorePaginated newStorePaginated = await _storeRepository.fetchStore(
            nextCursor: prevStorePaginatd.nextCursor);

        StorePaginated updatedStorePaginated = StorePaginated(
            data: [...prevStorePaginatd.data, ...newStorePaginated.data],
            nextCursor: newStorePaginated.nextCursor);

        emit(StoreSuccess(storePaginated: updatedStorePaginated));
      } catch (e) {
        emit(StoreErrorLoadingMore(
            storePaginated: prevStorePaginatd, errorMessage: e.toString()));
      }
    });
  }
}
