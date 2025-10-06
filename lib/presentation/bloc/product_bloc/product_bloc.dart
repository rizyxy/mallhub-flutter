import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:mallhub_flutter/data/paginated/product_paginated.dart';
import 'package:mallhub_flutter/data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());

      try {
        ProductPaginated productPaginated =
            await _productRepository.fetchProduct();

        emit(ProductSuccess(productPaginated: productPaginated));
      } catch (e) {
        emit(ProductError(errorMessage: e.toString()));
      }
    });

    on<FetchMoreProduct>((event, emit) async {
      if (!(state is ProductSuccess || state is ProductErrorLoadingMore)) {
        return;
      }

      ProductInitialLoadPassed prevState = state as ProductInitialLoadPassed;

      ProductPaginated prevProductPaginated = prevState.productPaginated;

      emit(ProductLoadingMore(products: prevProductPaginated.data));

      try {
        ProductPaginated newProductPaginated = await _productRepository
            .fetchProduct(nextCursor: prevProductPaginated.nextCursor);

        ProductPaginated updatedProductPaginated = ProductPaginated(
            data: [...prevProductPaginated.data, ...newProductPaginated.data],
            nextCursor: newProductPaginated.nextCursor);

        emit(ProductSuccess(productPaginated: updatedProductPaginated));
      } catch (e) {
        emit(ProductErrorLoadingMore(
            productPaginated: prevProductPaginated,
            errorMessage: e.toString()));
      }
    });
  }
}
