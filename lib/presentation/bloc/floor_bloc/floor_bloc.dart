import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/floor.dart';
import 'package:mallhub_flutter/data/repository/floor_repository.dart';

part 'floor_event.dart';
part 'floor_state.dart';

class FloorBloc extends Bloc<FloorEvent, FloorState> {
  final FloorRepository _floorRepository = FloorRepository();

  FloorBloc() : super(FloorInitial()) {
    on<FetchFloor>((event, emit) async {
      emit(FloorLoading());

      try {
        List<FloorModel> floors = await _floorRepository.fetchFloor();
        emit(FloorSuccess(floors: floors));
      } catch (e) {
        emit(FloorError(errorMessage: e.toString()));
      }
    });
  }
}
