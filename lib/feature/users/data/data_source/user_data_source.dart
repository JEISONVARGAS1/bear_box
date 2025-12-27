import 'package:bearbox/core/extension/stream_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class UserDataSource {
  Stream<List<UserModel>> getAllUserData();
  Future<void> deleteUser(String userId);
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final String userCollection = 'users';

  UserDataSourceImpl({required this.db, required this.auth});

  @override
  Stream<List<UserModel>> getAllUserData() {
    final docRef = db
        .collection(userCollection)
        .where('is_admin', isEqualTo: false);

    final res = docRef.snapshots();

    final stream =
        res.StreamToStream<
          QuerySnapshot<Map<String, dynamic>>,
          List<UserModel>
        >((data, sink) {
          final res = data.docs
              .map((e) => UserModel.fromJson(e.data(), e.reference))
              .toList();
          sink.add(res);
        });

    return stream;
  }

  @override
  Future<void> deleteUser(String userId) async {
    final docRef = db.collection(userCollection).doc(userId);
    await docRef.delete();
  }
}
