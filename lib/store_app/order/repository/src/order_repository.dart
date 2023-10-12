// ignore: library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as fStore;
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/delegate.dart';
import '../../../products/repository/model/porduct_model.dart';
import '../order_repository.dart';

abstract class _OrderRepository {
  Future<Order> fetchOneOrder(String id);
  Future<Delegate> fetchDelegate(String id);
  Future<List<Product>> fetchAllProducts(List<String> ids);
  Stream<List<Order>> fetchAllOrder();
}

class OrderRepository implements _OrderRepository {
  final fStore.FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderRepository()
      : _firestore = fStore.FirebaseFirestore.instance,
        _auth = FirebaseAuth.instance;

  @override
  Stream<List<Order>> fetchAllOrder() {
    try {
      return _firestore
          .collection('orders')
          .where('customer', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()
          .map((event) {
        return List<Order>.from(event.docs.map((e) => Order.fromMap(e.data())));
      });
    } catch (e) {
      return Stream.error(e);
    }
  }

  @override
  Future<Delegate> fetchDelegate(String id) async {
    try {
      return Delegate.fromMap(
          (await _firestore.collection('delegates').doc(id).get()).data()!);
    } catch (e) {
      print('fetchDelegate: $e');
      return Delegate.empty();
    }
  }

  @override
  Future<Order> fetchOneOrder(String id) async {
    try {
      return Order.fromMap(
          (await _firestore.collection('orders').doc(id).get()).data()!);
    } catch (e) {
      print('fetchOneOrder: $e');
      return Order.empty();
    }
  }

  @override
  Future<List<Product>> fetchAllProducts(List<String> ids) async {
    List<Product> products = [];
    try {
      // for (var element in ids) {
      await _firestore
          .collection('products')
          .where('id', whereIn: ids)
          .get()
          .then((value) {
        products = List<Product>.from(
            value.docs.map((e) => Product.fromMap(e.data())));
        // value.docs.map((e) {});
      });
      // }
      return products;
    } catch (e) {
      print('fetchAllProducts: $e');
      return [];
    }
  }
}
