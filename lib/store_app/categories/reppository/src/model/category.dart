import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  final String imageUrl;
  const Category({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [id, nameAr, nameEn, imageUrl];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'imageUrl': imageUrl,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String,
      nameAr: map['nameAr'] as String,
      nameEn: map['nameEn'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
