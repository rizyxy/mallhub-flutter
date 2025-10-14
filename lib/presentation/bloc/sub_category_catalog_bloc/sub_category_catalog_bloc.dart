import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';

part 'sub_category_catalog_event.dart';
part 'sub_category_catalog_state.dart';

class SubCategoryCatalogBloc
    extends Bloc<SubCategoryCatalogEvent, SubCategoryCatalogState> {
  SubCategoryCatalogBloc() : super(SubCategoryCatalogInitial()) {
    on<FetchSubCategoryCatalog>((event, emit) async {
      emit(SubCategoryCatalogLoading());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(SubCategoryCatalogSuccess(
            productPaginated: ProductPaginated(data: [])));
      } catch (e) {
        emit(SubCategoryCatalogError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreSubCategoryCatalog>((event, emit) async {
      emit(SubCategoryCatalogLoadingMore(
          productPaginated: ProductPaginated(data: [])));

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(SubCategoryCatalogSuccess(
            productPaginated: ProductPaginated(data: [])));
      } catch (e) {
        emit(SubCategoryCatalogErrorLoadingMore(
            productPaginated: ProductPaginated(data: []),
            errorMessage: e.toString()));
      }
    });
  }
}
