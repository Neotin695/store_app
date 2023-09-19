import 'package:equatable/equatable.dart';

import '../../../../../models/address_info.dart';

class Store extends Equatable {
  final String id;

  final String name;
  final bool active;
  final String category;
  final String logoUrl;

  final String coverUrl;

  final AddressInfo addressInfo;
  final List<String> reviews;
  const Store(
      {required this.id,
      required this.active,
      required this.category,
      required this.logoUrl,
      required this.name,
      required this.coverUrl,
      required this.addressInfo,
      required this.reviews});

  static Store empty() => Store(
        id: '',
        active: false,
        category: '',
        name: '',
        logoUrl: '',
        coverUrl: '',
        addressInfo: AddressInfo.empty(),
        reviews: const [],
      );

  @override
  List<Object?> get props =>
      [id, active, category, name, logoUrl, coverUrl, addressInfo, reviews];

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as String,
      active: map['active'] as bool,
      category: map['category'] as String,
      logoUrl: map['logoUrl'] as String,
      coverUrl: map['coverUrl'] as String,
      name: map['name'] as String,
      addressInfo:
          AddressInfo.fromMap(map['addressInfo'] as Map<String, dynamic>),
      reviews: List<String>.from(map['reviews'].map((e) => e)),
    );
  }
}
