import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<FetchStore>((event, emit) async {
      emit(StoreLoading());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(StoreSuccess());
      } catch (e) {
        emit(StoreError());
      }
    });

    on<FetchMoreStore>((event, emit) async {
      emit(StoreLoadingMore());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(StoreErrorLoadingMore());
      } catch (e) {
        emit(StoreErrorLoadingMore());
      }
    });
  }
}
