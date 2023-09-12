import 'package:equatable/equatable.dart';

import '../../../../models/review.dart';

class Product extends Equatable {
  final String id;
  final String titleEn;
  final String descriptionEn;
  final String titleAr;
  final String descriptionAr;
  final String coverUrl;
  final String storeId;
  final List<String> images;
  final bool soldOut;
  final String category;
  final double price;
  final int quantity;
  final int discount;
  final bool active;

  final List<Review> reviews;

  const Product({
    required this.id,
    required this.titleAr,
    required this.descriptionAr,
    required this.titleEn,
    required this.storeId,
    required this.descriptionEn,
    required this.coverUrl,
    required this.images,
    required this.active,
    required this.soldOut,
    required this.category,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.reviews,
  });

  static Product empty() => const Product(
        id: '',
        titleEn: '',
        descriptionEn: '',
        titleAr: '',
        storeId: '',
        descriptionAr: '',
        coverUrl: '',
        images: [],
        soldOut: false,
        category: '',
        price: 0,
        active: false,
        quantity: 0,
        discount: 0,
        reviews: [],
      );

  @override
  List<Object?> get props => [
        id,
        titleAr,
        descriptionAr,
        titleEn,
        storeId,
        descriptionEn,
        coverUrl,
        images,
        soldOut,
        category,
        price,
        active,
        quantity,
        discount,
        reviews
      ];

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      titleEn: map['titleEn'] as String,
      descriptionEn: map['descriptionEn'] as String,
      titleAr: map['titleAr'] as String,
      storeId: map['storeId'] as String,
      descriptionAr: map['descriptionAr'] as String,
      coverUrl: map['coverUrl'] as String,
      images: List<String>.from(map['images'].map((e) => e)),
      soldOut: map['soldOut'] as bool,
      category: map['category'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      discount: map['discount'] as int,
      active: map['active'] as bool,
      reviews: List<Review>.from(map['reviews'].map((e) => Review.fromMap(e))),
    );
  }
}
