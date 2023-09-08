import 'package:equatable/equatable.dart';
import 'package:store_app/models/product_quantity.dart';

class Cart extends Equatable {
  final String id;
  final List<String> products;
  final List<ProductQuantity> quantity;
  const Cart({
    required this.id,
    required this.products,
    required this.quantity,
  });

  @override
  List<Object> get props => [id, products, quantity];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      products: List<String>.from((map['products'] as List<String>)),
      quantity: List<ProductQuantity>.from((map['quantity'].map((e) => e))),
    );
  }
}
