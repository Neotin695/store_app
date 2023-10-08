import 'package:equatable/equatable.dart';

class StoreCategory extends Equatable {
  final String nameAr;
  final String nameEn;
  const StoreCategory({
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object> get props => [nameAr, nameEn];

  static StoreCategory empty() => const StoreCategory(nameAr: '', nameEn: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }

  factory StoreCategory.fromMap(Map<String, dynamic> map) {
    return StoreCategory(
      nameAr: map['nameAr'] as String,
      nameEn: map['nameEn'] as String,
    );
  }
}
