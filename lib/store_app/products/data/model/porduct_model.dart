import 'package:store_app/store_app/products/domain/entities/product_entity.dart';

import '../../../../models/review.dart';

class ProductModel extends ProductEntity {
  const ProductModel(
      {required super.id,
      required super.titleAr,
      required super.descriptionAr,
      required super.titleEn,
      required super.descriptionEn,
      required super.coverUrl,
      required super.images,
      required super.active,
      required super.soldOut,
      required super.category,
      required super.price,
      required super.quantity,
      required super.discount,
      required super.reviews});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titleEn': titleEn,
      'descriptionEn': descriptionEn,
      'titleAr': titleAr,
      'descriptionAr': descriptionAr,
      'coverUrl': coverUrl,
      'images': images,
      'soldOut': soldOut,
      'category': category,
      'price': price,
      'quantity': quantity,
      'discount': discount,
      'active': active,
      'reviews': reviews.map((x) => x.toMap()).toList(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      titleEn: map['titleEn'] as String,
      descriptionEn: map['descriptionEn'] as String,
      titleAr: map['titleAr'] as String,
      descriptionAr: map['descriptionAr'] as String,
      coverUrl: map['coverUrl'] as String,
      images: List<String>.from(map['images'].map((e) => e)),
      soldOut: map['soldOut'] as bool,
      category: map['category'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
      discount: map['discount'] as int,
      active: map['active'] as bool,
      reviews: List<Review>.from(
        map['reviews'].map<Review>(
          (x) => Review.fromMap(x),
        ),
      ),
    );
  }
  @override
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
