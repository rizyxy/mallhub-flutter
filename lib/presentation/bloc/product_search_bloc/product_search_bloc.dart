import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';
import 'package:mallhub_flutter/data/repository/product_repository.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final ProductRepository _productRepository = ProductRepository();

  ProductSearchBloc() : super(ProductSearchInitial()) {
    on<FetchSearchedProduct>((event, emit) async {
      if (event.searchQuery == "") {
        return;
      }

      emit(ProductSearchLoading());

      try {
        ProductPaginated productPaginated = await _productRepository
            .fetchProduct(searchQuery: event.searchQuery);

        emit(ProductSearchSuccess(productPaginated: productPaginated));
      } catch (e) {
        emit(ProductSearchError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreSearchedProduct>((event, emit) async {
      if (!(state is ProductSearchSuccess ||
          state is ProductSearchErrorLoadingMore)) {
        return;
      }

      ProductSearchInitialLoadPassed prevState =
          state as ProductSearchInitialLoadPassed;

      ProductPaginated prevProductPaginated = prevState.productPaginated;

      emit(ProductSearchLoadingMore(productPaginated: prevProductPaginated));

      try {
        ProductPaginated newProductPaginated =
            await _productRepository.fetchProduct(
                searchQuery: event.searchQuery,
                nextCursor: prevProductPaginated.nextCursor);

        ProductPaginated updatedProductPaginated = ProductPaginated(
            data: [...prevProductPaginated.data, ...newProductPaginated.data],
            nextCursor: newProductPaginated.nextCursor);

        emit(ProductSearchSuccess(productPaginated: updatedProductPaginated));
      } catch (e) {
        emit(ProductSearchErrorLoadingMore(
            productPaginated: prevProductPaginated));
      }
    });

    on<ClearSearchedProduct>((event, emit) {
      emit(ProductSearchInitial());
    });
  }
}
