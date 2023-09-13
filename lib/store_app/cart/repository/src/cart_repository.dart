import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app/models/product_quantity.dart';

import '../cart_repository.dart';

abstract class _CartRepository {
  Stream<Cart> fetchAllCartItems();

  Future<void> checkout(Cart cart);

  Future<void> removeFromCart(String productId);

  Future<void> handleQuantity(ProductQuantity productQuantity);
}

class CartRepository extends _CartRepository {
  final FirebaseFirestore _store;
  CartRepository() : _store = FirebaseFirestore.instance;
  @override
  Future<void> checkout(Cart cart) {
    // TODO: implement checkout
    throw UnimplementedError();
  }

  @override
  Future<void> handleQuantity(ProductQuantity productQuantity) async {
    await _store
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      final cart = Cart.fromMap(value.data()!);
      final index = cart.quantities.indexWhere(
          (element) => element.productId == productQuantity.productId);
      cart.quantities[index] = productQuantity;

      await _store
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(cart.toMap());
    });
  }

  @override
  Stream<Cart> fetchAllCartItems() {
    return _store
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => Cart.fromMap(event.data()!));
  }

  @override
  Future<void> removeFromCart(String productId) async {
    await _store
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      final cart = Cart.fromMap(value.data()!);

      // ignore: list_remove_unrelated_type
      cart.quantities.removeWhere((e) => e.productId == productId);

      await _store
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(cart.toMap());
    });
  }
}
