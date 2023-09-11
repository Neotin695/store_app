import 'package:store_app/models/product_quantity.dart';

import '../../../../models/cart.dart';

abstract class _CartRepository {
  Stream<List<Cart>> fetchAllCartItems();

  Future<void> checkout(Cart cart);

  Future<void> removeFromCart(String productId);

  Future<void> increaseQuantity(ProductQuantity productQuantity);

  Future<void> decreaseQuantity(ProductQuantity productQuantity);
}

class CartRepository extends _CartRepository {
  @override
  Future<void> checkout(Cart cart) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<void> decreaseQuantity(ProductQuantity productQuantity) {
    // TODO: implement decreaseQuantity
    throw UnimplementedError();
  }

  @override
  Stream<List<Cart>> fetchAllCartItems() {
    // TODO: implement fetchAllCartItems
    throw UnimplementedError();
  }

  @override
  Future<void> increaseQuantity(ProductQuantity productQuantity) {
    // TODO: implement increaseQuantity
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromCart(String productId) {
    // TODO: implement removeFromCart
    throw UnimplementedError();
  }
}
