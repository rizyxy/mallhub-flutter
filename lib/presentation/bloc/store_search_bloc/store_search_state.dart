part of 'store_search_bloc.dart';

sealed class StoreSearchState extends Equatable {
  const StoreSearchState();

  @override
  List<Object?> get props => [];
}

class StoreSearchInitial extends StoreSearchState {}

abstract class StoreSearchInitialLoadPassed extends StoreSearchState {
  final StorePaginated storePaginated;

  const StoreSearchInitialLoadPassed({required this.storePaginated});

  @override
  List<Object?> get props => [storePaginated];
}

class StoreSearchLoading extends StoreSearchState {}

class StoreSearchLoadingMore extends StoreSearchInitialLoadPassed {
  const StoreSearchLoadingMore({required super.storePaginated});
}

class StoreSearchSuccess extends StoreSearchInitialLoadPassed {
  const StoreSearchSuccess({required super.storePaginated});
}

class StoreSearchError extends StoreSearchState {
  final String? errorMessage;

  const StoreSearchError({this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class StoreSearchErrorLoadingMore extends StoreSearchInitialLoadPassed {
  const StoreSearchErrorLoadingMore({required super.storePaginated});
}
