import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<_FetchAllProducts>(_fetchAllProducts);
  }
  late final StreamSubscription<List<ProductEntity>> _subscription;

  @override
  Future close() {
    _subscription.cancel();
    return super.close();
  }

  FutureOr<void> _fetchAllProducts(_FetchAllProducts event, emit) {
    emit(ProductsLoading());
    if (event.products.isNotEmpty) {
      emit(ProductsLoaded(products: event.products));
    }
  }
}
