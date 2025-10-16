import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/store_paginated.dart';

part 'store_search_event.dart';
part 'store_search_state.dart';

class StoreSearchBloc extends Bloc<StoreSearchEvent, StoreSearchState> {
  StoreSearchBloc() : super(StoreSearchInitial()) {
    on<FetchSearchedStore>((event, emit) async {
      emit(StoreSearchLoading());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(StoreSearchSuccess(storePaginated: StorePaginated(data: [])));
      } catch (e) {
        emit(StoreSearchError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreSearchedStore>((event, emit) async {
      emit(StoreSearchLoadingMore(storePaginated: StorePaginated(data: [])));

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(StoreSearchSuccess(storePaginated: StorePaginated(data: [])));
      } catch (e) {
        emit(StoreSearchErrorLoadingMore(
            storePaginated: StorePaginated(data: [])));
      }
    });

    on<ClearSearchedStore>((event, emit) {
      emit(StoreSearchInitial());
    });
  }
}
