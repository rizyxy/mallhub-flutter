import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';
import 'package:mallhub_flutter/data/repository/store_repository.dart';

part 'store_catalog_state.dart';
part 'store_catalog_event.dart';

class StoreCatalogBloc extends Bloc<StoreCatalogEvent, StoreCatalogState> {
  final StoreRepository _storeRepository = StoreRepository();

  StoreCatalogBloc() : super(StoreCatalogInitial()) {
    on<FetchStoreCatalog>((event, emit) async {
      emit(StoreCatalogLoading());

      try {
        ProductPaginated productPaginated =
            await _storeRepository.fetchStoreCatalog(storeId: event.storeId);

        emit(StoreCatalogSuccess(productPaginated: productPaginated));
      } catch (e) {
        emit(StoreCatalogError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreStoreCatalog>((event, emit) async {
      if (!(state is StoreCatalogSuccess ||
          state is StoreCatalogErrorLoadingMore)) {
        return;
      }

      StoreCatalogInitialLoadPassed prevState =
          state as StoreCatalogInitialLoadPassed;

      ProductPaginated prevProductPaginated = prevState.productPaginated;

      emit(StoreCatalogLoadingMore(productPaginated: prevProductPaginated));

      try {
        ProductPaginated newProductPaginated =
            await _storeRepository.fetchStoreCatalog(storeId: event.storeId);

        ProductPaginated updatedProductPaginated = ProductPaginated(
            data: [...prevProductPaginated.data, ...newProductPaginated.data],
            nextCursor: newProductPaginated.nextCursor);

        emit(StoreCatalogSuccess(productPaginated: updatedProductPaginated));
      } catch (e) {
        emit(StoreCatalogErrorLoadingMore(
            productPaginated: prevProductPaginated));
      }
    });
  }
}
