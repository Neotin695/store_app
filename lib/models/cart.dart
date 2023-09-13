// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:store_app/models/product_quantity.dart';

// ignore: must_be_immutable
class Cart extends Equatable {
  final String id;

  List<ProductQuantity> quantity;
  Cart({
    required this.id,
    required this.quantity,
  });

  @override
  List<Object> get props => [id, quantity];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      quantity: List<ProductQuantity>.from((map['quantity'].map((e) => e))),
    );
  }

  Cart copyWith({
    String? id,
    List<ProductQuantity>? quantity,
  }) {
    return Cart(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
    );
  }
}
