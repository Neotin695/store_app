import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app/models/cart.dart';
import 'package:store_app/models/review.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';
import 'package:store_app/store_app/store/repository/src/models/category.dart';

import 'models/store.dart';

abstract class _StoreRepository {
  Stream<List<Store>> fetchStore();

  Future<void> addToCart(Cart cart);

  Future<void> addReview(List<Review> review, String storeId);

  Stream<List<Product>> fetchProductOfStore(String storeId);

  Future<StoreCategory> populateStoreCategory(String categoryId);
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
  Future<StoreCategory> populateStoreCategory(String categoryId) async {
    return StoreCategory.fromMap(
        (await _store.collection('category').doc(categoryId).get()).data()!);
  }

  @override
  Future<void> addToCart(Cart cart) async {
    await _store
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) async {
      final cartOriginal = Cart.fromMap(value.data()!);
      final index = cartOriginal.quantity
          .indexWhere((element) => element == cart.quantity.first);
      if (index == -1) {
        cartOriginal.quantity.add(cart.quantity.first);
      } else {
        cartOriginal.quantity.insert(index, cart.quantity.first);
      }
      await _store
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(cartOriginal.toMap());
    });
  }
}
