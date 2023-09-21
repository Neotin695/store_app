import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:store_app/models/product_quantity.dart';

import '../repository/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(this._cartRepository) : super(CartInitial()) {
    on<_FetchAllCart>(_fetchAllCarts);
    on<IncreaseQuantity>(_increaseQuantity);
    on<DecreaseQuantity>(_decrease);
    on<RemoveFromCart>(_removeFromCart);
    add(_FetchAllCart());
  }

  FutureOr<void> _removeFromCart(RemoveFromCart event, emit) async {
    emit(CartLoading());
    await _cartRepository
        .removeFromCart(event.count.productId)
        .then((value) => add(_FetchAllCart()));
  }

  FutureOr<void> _decrease(DecreaseQuantity event, emit) async {
    await _cartRepository
        .handleQuantity(event.count)
        .then((value) => add(_FetchAllCart()));
  }
  
  FutureOr<void> _increaseQuantity(IncreaseQuantity event, emit) async {
    await _cartRepository
        .handleQuantity(event.count)
        .then((value) => add(_FetchAllCart()));
  }

  final CartRepository _cartRepository;
  FutureOr<void> _fetchAllCarts(event, Emitter<CartState> emit) async {
    emit(CartLoading());
    await emit.forEach(_cartRepository.fetchAllCartItems(), onData: (data) {
      return CartLoaded(cart: data);
    }, onError: (__, _) {
      return CartFailure();
    });
  }
}
