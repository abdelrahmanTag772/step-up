import 'package:bloc/bloc.dart';
import 'package:digital_egypt_pioneers/bloc/product/product_event.dart';
import 'package:digital_egypt_pioneers/bloc/product/product_state.dart';
import 'package:digital_egypt_pioneers/services/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _productRepository.getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}