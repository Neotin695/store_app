import 'package:equatable/equatable.dart';

import 'package:store_app/models/product_quantity.dart';

class Cart extends Equatable {
  final String id;
  final List<String> products;
  final List<ProductQuantity> quantities;
  final String customerId;
  const Cart({
    required this.id,
    required this.products,
    required this.quantities,
    required this.customerId,
  });

  @override
  List<Object> get props => [id, products, quantities, customerId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products,
      'quantities': quantities.map((x) => x.toMap()).toList(),
      'customerId': customerId,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      products: List<String>.from((map['products'] as List<String>)),
      quantities: List<ProductQuantity>.from(
          map['quantities'].map((e) => ProductQuantity.fromMap(e))),
      customerId: map['customerId'] as String,
    );
  }
}
