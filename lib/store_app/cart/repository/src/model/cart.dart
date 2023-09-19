// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:store_app/models/product_quantity.dart';

class Cart extends Equatable {
  final String id;
  List<ProductQuantity> quantities;
  Cart({
    required this.id,
    required this.quantities,
  });

  @override
  List<Object> get props => [id, quantities];

  static Cart empty() => Cart(id: '', quantities: const []);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantities': quantities.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      quantities: List<ProductQuantity>.from(
          map['quantities'].map((e) => ProductQuantity.fromMap(e))),
    );
  }

  Cart copyWith({
    String? id,
    List<ProductQuantity>? quantities,
    String? customerId,
  }) {
    return Cart(
      id: id ?? this.id,
      quantities: quantities ?? this.quantities,
    );
  }
}
