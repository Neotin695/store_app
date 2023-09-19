import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/model.dart';

abstract class _BannersRepository {
  Stream<List<Banner>> fetchAllBanners();
}

class BannerRepository extends _BannersRepository {
  final FirebaseFirestore _firestore;

  BannerRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Banner>> fetchAllBanners() {
    return _firestore.collection('banners').snapshots().map(
        (event) => event.docs.map((e) => Banner.fromMap(e.data())).toList());
  }
}
