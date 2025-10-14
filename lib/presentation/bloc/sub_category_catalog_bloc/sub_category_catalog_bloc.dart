import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';
import 'package:mallhub_flutter/data/repository/sub_category_repository.dart';

part 'sub_category_catalog_event.dart';
part 'sub_category_catalog_state.dart';

class SubCategoryCatalogBloc
    extends Bloc<SubCategoryCatalogEvent, SubCategoryCatalogState> {
  final SubCategoryRepository _subCategoryRepository = SubCategoryRepository();

  SubCategoryCatalogBloc() : super(SubCategoryCatalogInitial()) {
    on<FetchSubCategoryCatalog>((event, emit) async {
      emit(SubCategoryCatalogLoading());

      try {
        ProductPaginated productPaginated = await _subCategoryRepository
            .fetchSubCategoryCatalog(subCategoryId: event.subCategoryId);

        emit(SubCategoryCatalogSuccess(productPaginated: productPaginated));
      } catch (e) {
        emit(SubCategoryCatalogError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreSubCategoryCatalog>((event, emit) async {
      if (!(state is SubCategoryCatalogSuccess ||
          state is SubCategoryCatalogErrorLoadingMore)) {
        return;
      }

      SubCategoryCatalogInitialLoadPassed prevState =
          state as SubCategoryCatalogInitialLoadPassed;

      ProductPaginated prevProductPaginated = prevState.productPaginated;

      emit(SubCategoryCatalogLoadingMore(
          productPaginated: prevProductPaginated));

      try {
        ProductPaginated newProductPaginated =
            await _subCategoryRepository.fetchSubCategoryCatalog(
                subCategoryId: event.subCategoryId,
                cursor: prevProductPaginated.nextCursor);

        ProductPaginated updatedProductPaginated = ProductPaginated(
            data: [...prevProductPaginated.data, ...newProductPaginated.data],
            nextCursor: newProductPaginated.nextCursor);

        emit(SubCategoryCatalogSuccess(
            productPaginated: updatedProductPaginated));
      } catch (e) {
        emit(SubCategoryCatalogErrorLoadingMore(
            productPaginated: prevProductPaginated,
            errorMessage: e.toString()));
      }
    });
  }
}
