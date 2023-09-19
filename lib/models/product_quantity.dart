// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductQuantity extends Equatable {
  final String productId;
  int quantity;
  ProductQuantity({
    required this.productId,
    required this.quantity,
  });

  static ProductQuantity empty() => ProductQuantity(productId: '', quantity: 0);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory ProductQuantity.fromMap(Map<String, dynamic> map) {
    return ProductQuantity(
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }

  @override
  List<Object?> get props => [productId, quantity];

  @override
  bool get stringify => true;

  @override
  String toString() {
    // TODO: implement toString
    return 'quantity \n $quantity';
  }

  ProductQuantity copyWith({
    String? productId,
    int? quantity,
  }) {
    return ProductQuantity(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
