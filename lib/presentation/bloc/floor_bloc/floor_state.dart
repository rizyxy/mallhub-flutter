part of 'floor_bloc.dart';

sealed class FloorState extends Equatable {
  const FloorState();

  @override
  List<Object?> get props => [];
}

class FloorInitial extends FloorState {}

class FloorLoading extends FloorState {}

class FloorSuccess extends FloorState {
  final List<FloorModel> floors;

  const FloorSuccess({required this.floors});

  @override
  List<Object?> get props => [floors];
}

class FloorError extends FloorState {
  final String? errorMessage;

  const FloorError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
