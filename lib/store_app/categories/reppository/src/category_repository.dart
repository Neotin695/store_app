import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/model.dart';

abstract class _CategoryRepository {
  Stream<List<Category>> fetchAllCategories();
}

class CategoryRepository extends _CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepository() : _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Category>> fetchAllCategories() {
    return _firestore.collection('category').snapshots().map(
        (event) => event.docs.map((e) => Category.fromMap(e.data())).toList());
  }
}
