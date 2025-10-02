part of 'store_bloc.dart';

sealed class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class FetchStore extends StoreEvent {}

class FetchMoreStore extends StoreEvent {}
