import 'package:equatable/equatable.dart';

import '../../../../models/review.dart';

class ProductEntity extends Equatable {
  final String id;
  final String titleEn;
  final String descriptionEn;
  final String titleAr;
  final String descriptionAr;
  final String coverUrl;
  final List<String> images;
  final bool soldOut;
  final String category;
  final double price;
  final int quantity;
  final int discount;
  final bool active;
  final List<Review> reviews;

  const ProductEntity({
    required this.id,
    required this.titleAr,
    required this.descriptionAr,
    required this.titleEn,
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

  static ProductEntity empty() => const ProductEntity(
        id: '',
        titleEn: '',
        descriptionEn: '',
        titleAr: '',
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

  ProductEntity copyWith({
    String? id,
    String? titleEn,
    String? descriptionEn,
    String? titleAr,
    String? descriptionAr,
    String? coverUrl,
    List<String>? images,
    bool? soldOut,
    String? category,
    double? price,
    int? quantity,
    int? discount,
    bool? active,
    List<Review>? reviews,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      titleEn: titleEn ?? this.titleEn,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      titleAr: titleAr ?? this.titleAr,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      coverUrl: coverUrl ?? this.coverUrl,
      images: images ?? this.images,
      soldOut: soldOut ?? this.soldOut,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      discount: discount ?? this.discount,
      active: active ?? this.active,
      reviews: reviews ?? this.reviews,
    );
  }
}
