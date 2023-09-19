
import 'package:equatable/equatable.dart';

class Banner extends Equatable {
  final String id;
  final String photoUrl;
  const Banner({
    required this.id,
    required this.photoUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'photoUrl': photoUrl,
    };
  }

  factory Banner.fromMap(Map<String, dynamic> map) {
    return Banner(
      id: map['id'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  

  @override
  List<Object> get props => [id, photoUrl];
}
