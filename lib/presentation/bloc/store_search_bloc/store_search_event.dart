part of 'store_search_bloc.dart';

sealed class StoreSearchEvent extends Equatable {
  const StoreSearchEvent();

  @override
  List<Object?> get props => [];
}

class FetchSearchedStore extends StoreSearchEvent {
  final String searchQuery;

  const FetchSearchedStore({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class FetchMoreSearchedStore extends StoreSearchEvent {
  final String searchQuery;

  const FetchMoreSearchedStore({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class ClearSearchedStore extends StoreSearchEvent {}
