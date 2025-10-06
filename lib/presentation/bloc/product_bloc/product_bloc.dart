import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProduct>((event, emit) async {
      emit(ProductLoading());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(ProductSuccess());
      } catch (e) {
        emit(ProductError());
      }
    });
  }
}
