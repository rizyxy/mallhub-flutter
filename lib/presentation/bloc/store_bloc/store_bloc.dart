import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/store.dart';
import 'package:mallhub_flutter/data/repository/store_repository.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoreRepository _storeRepository = StoreRepository();

  StoreBloc() : super(StoreInitial()) {
    on<FetchStore>((event, emit) async {
      emit(StoreLoading());

      try {
        List<StoreModel> stores = await _storeRepository.fetchStore();

        emit(StoreSuccess(stores: stores));
      } catch (e) {
        emit(StoreError());
      }
    });

    on<FetchMoreStore>((event, emit) async {
      StoreSuccess prevState = (state as StoreSuccess);

      emit(StoreLoadingMore(stores: prevState.stores));

      try {
        List<StoreModel> newStores = await _storeRepository.fetchStore();

        List<StoreModel> updatedStores = [...prevState.stores, ...newStores];

        emit(StoreSuccess(stores: updatedStores));
      } catch (e) {
        emit(StoreErrorLoadingMore(stores: prevState.stores));
      }
    });
  }
}
