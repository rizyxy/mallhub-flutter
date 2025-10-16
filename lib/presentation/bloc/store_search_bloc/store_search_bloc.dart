import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/store_paginated.dart';
import 'package:mallhub_flutter/data/repository/store_repository.dart';

part 'store_search_event.dart';
part 'store_search_state.dart';

class StoreSearchBloc extends Bloc<StoreSearchEvent, StoreSearchState> {
  final StoreRepository _storeRepository = StoreRepository();

  StoreSearchBloc() : super(StoreSearchInitial()) {
    on<FetchSearchedStore>((event, emit) async {
      emit(StoreSearchLoading());

      try {
        StorePaginated storePaginated =
            await _storeRepository.fetchStore(searchQuery: event.searchQuery);

        emit(StoreSearchSuccess(storePaginated: storePaginated));
      } catch (e) {
        emit(StoreSearchError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreSearchedStore>((event, emit) async {
      if (!(state is StoreSearchBloc || state is StoreSearchErrorLoadingMore)) {
        return;
      }

      StoreSearchInitialLoadPassed prevState =
          state as StoreSearchInitialLoadPassed;

      StorePaginated prevStorePaginated = prevState.storePaginated;

      emit(StoreSearchLoadingMore(storePaginated: prevStorePaginated));
      try {
        StorePaginated newStorePaginated = await _storeRepository.fetchStore(
            nextCursor: prevStorePaginated.nextCursor,
            searchQuery: event.searchQuery);

        StorePaginated updatedStorePaginated = StorePaginated(
            data: [...prevStorePaginated.data, ...newStorePaginated.data],
            nextCursor: newStorePaginated.nextCursor);

        emit(StoreSearchSuccess(storePaginated: updatedStorePaginated));
      } catch (e) {
        emit(StoreSearchErrorLoadingMore(
            storePaginated: prevStorePaginated, errorMessage: e.toString()));
      }
    });

    on<ClearSearchedStore>((event, emit) {
      emit(StoreSearchInitial());
    });
  }
}
