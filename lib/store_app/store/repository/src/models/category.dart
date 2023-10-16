import 'package:equatable/equatable.dart';

class StoreCategory extends Equatable {
  final String id;
  final String nameAr;
  final String nameEn;
  const StoreCategory({
    required this. id,
    required this.nameAr,
    required this.nameEn,
  });

  @override
  List<Object> get props => [nameAr, nameEn];

  static StoreCategory empty() => const StoreCategory(id:'',nameAr: '', nameEn: '');


  factory StoreCategory.fromMap(Map<String, dynamic> map) {
    return StoreCategory(
      nameAr: map['nameAr'] as String,
      nameEn: map['nameEn'] as String,
      id: map['id'] as String,
    );
  }
}
