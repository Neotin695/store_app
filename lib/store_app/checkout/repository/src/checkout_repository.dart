import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart' as fStore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app/store_app/cart/repository/src/model/cart.dart';
import 'package:store_app/store_app/products/repository/model/porduct_model.dart';

import '../../../../models/model.dart';
import '../../../order/repository/order_repository.dart';


abstract class _CheckOutRepository {
  Future<void> placeOrder(Cart cart);
}

class CheckOutRepository implements _CheckOutRepository {
  final fStore.FirebaseFirestore _firestore;
  CheckOutRepository() : _firestore = fStore.FirebaseFirestore.instance;

  @override
  Future<void> placeOrder(Cart cart) async {
    final prodcutIds = List<String>.from(
      cart.quantities.map<String>((e) => e.productId),
    );
    List<Product> updatedProductsPrice = [];
    double totalPrice = 0;
    await _firestore
        .collection('products')
        .where('id', whereIn: prodcutIds)
        .get()
        .then((value) async {
      final products =
          List<Product>.from(value.docs.map((e) => Product.fromMap(e.data())));
      for (var pro in products) {
        final product = cart.quantities
            .firstWhere((element) => element.productId == pro.id);

        updatedProductsPrice
            .add(pro.copyWith(price: pro.price * product.quantity));
      }

      for (var element in updatedProductsPrice) {
        totalPrice += element.price;
      }
      final docId = _firestore.collection('orders').doc().id;
      final orderNum = Random.secure().nextInt(1000000);
      await _firestore.collection('orders').doc(docId).set(Order(
          id: docId,
          productQuantity: cart.quantities,
          orderNum: '$orderNum',
          deliveryPrice: totalPrice,
          acceptable: false,
          customer: FirebaseAuth.instance.currentUser!.uid,
          delivered: false,
          delegate: '',
          deliveryDate: fStore.Timestamp.now(),
          addressInfo: AddressInfo.empty(),
          paymentMethod: 'visa').toMap());
    });
  }
}
