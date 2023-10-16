import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app/models/review.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';
import 'package:store_app/store_app/store/repository/src/models/category.dart';

import '../../../cart/repository/cart_repository.dart';
import 'models/store.dart';

abstract class _StoreRepository {
  Stream<List<Store>> fetchStore();

  Future<void> addToCart(Cart cart);

  Future<void> addReview(List<Review> review, String storeId);

  Stream<List<Product>> fetchProductOfStore(String storeId);

  Future<List<StoreCategory>> populateStoreCategory();
}

class StoreRepository extends _StoreRepository {
  final FirebaseFirestore _store;

  StoreRepository() : _store = FirebaseFirestore.instance;

  @override
  Stream<List<Store>> fetchStore() {
    return _store.collection('stores').snapshots().map(
        (event) => event.docs.map((e) => Store.fromMap(e.data())).toList());
  }

  @override
  Stream<List<Product>> fetchProductOfStore(String storeId) {
    return _store
        .collection('products')
        .where('storeId', isEqualTo: storeId)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Product.fromMap(e.data()),
              )
              .toList(),
        );
  }

  @override
  Future<void> addReview(List<Review> review, String storeId) async {
    await _store.collection('stores').doc(storeId).update({'reviews': review});
  }

  @override
  Future<List<StoreCategory>> populateStoreCategory() async {
    return List<StoreCategory>.from((await _store.collection('category').get())
        .docs
        .map((e) => StoreCategory.fromMap(e.data())));
  }

  @override
  Future<void> addToCart(Cart cart) async {
    await _store
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.data() != null) {
        await _whenCartIsEmpty(value, cart);
      } else {
        await _whenCartIsNotEmpty(cart);
      }
    });
  }

  Future<void> _whenCartIsNotEmpty(Cart cart) async {
    await _store
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(cart.copyWith(id: FirebaseAuth.instance.currentUser!.uid).toMap());
  }

  Future<void> _whenCartIsEmpty(
      DocumentSnapshot<Map<String, dynamic>> value, Cart cart) async {
    final cartOriginal = Cart.fromMap(value.data()!);
    final index = cartOriginal.quantities.indexWhere(
        (element) => element.productId == cart.quantities.first.productId);

    if (index == -1) {
      cartOriginal.quantities.add(cart.quantities.first);
      await _store
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(cartOriginal.toMap());
    }
  }
}
