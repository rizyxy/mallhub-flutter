part of 'product_search_bloc.dart';

sealed class ProductSearchEvent extends Equatable {
  const ProductSearchEvent();

  @override
  List<Object?> get props => [];
}

class ClearSearchedProduct extends ProductSearchEvent {}

class FetchSearchedProduct extends ProductSearchEvent {
  final String searchQuery;

  const FetchSearchedProduct({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class FetchMoreSearchedProduct extends ProductSearchEvent {
  final String searchQuery;

  const FetchMoreSearchedProduct({required this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}
