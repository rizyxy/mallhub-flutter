import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mallhub_flutter/data/model/product.dart';
import 'package:mallhub_flutter/data/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository = ProductRepository();

  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());

      try {
        final List<ProductModel> products =
            await productRepository.getProducts();

        emit(ProductSuccess(products: products));
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}
