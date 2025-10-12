import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/floor.dart';

part 'floor_event.dart';
part 'floor_state.dart';

class FloorBloc extends Bloc<FloorEvent, FloorState> {
  FloorBloc() : super(FloorInitial()) {
    on<FetchFloor>((event, emit) async {
      emit(FloorLoading());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(FloorSuccess(floors: []));
      } catch (e) {
        emit(FloorError(errorMessage: e.toString()));
      }
    });
  }
}
