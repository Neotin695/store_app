import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store_app/models/customer.dart';

abstract class _ProfileRepo {
  Future<Customer> fetchUserData();
}

class ProfileRepo implements _ProfileRepo {
  final FirebaseFirestore _firestore;

  ProfileRepo() : _firestore = FirebaseFirestore.instance;

  @override
  Future<Customer> fetchUserData() async {
    return Customer.fromMap((await _firestore
            .collection('customers')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .data()!);
  }
}
