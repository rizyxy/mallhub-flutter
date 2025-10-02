part of 'store_bloc.dart';

sealed class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

abstract class StoreInitialLoadPassed extends StoreState {
  final StorePaginated storePaginated;

  const StoreInitialLoadPassed({required this.storePaginated});

  @override
  List<Object?> get props => [storePaginated];
}

class StoreLoading extends StoreState {}

class StoreLoadingMore extends StoreState {
  final List<StoreModel> stores;

  const StoreLoadingMore({required this.stores});

  @override
  List<Object?> get props => [stores];
}

class StoreSuccess extends StoreInitialLoadPassed {
  const StoreSuccess({required super.storePaginated});

  @override
  List<Object?> get props => [storePaginated];
}

class StoreError extends StoreState {
  final String? errorMessage;

  const StoreError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class StoreErrorLoadingMore extends StoreInitialLoadPassed {
  final String? errorMessage;

  const StoreErrorLoadingMore(
      {required super.storePaginated, this.errorMessage});

  @override
  List<Object?> get props => [storePaginated, errorMessage];
}
