import 'package:bearbox/core/app/shared_preferences_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class HomeDataSource {
  Future<void> logout();
  Future<UserModel> getUserDataByEmail(String email);
}

class HomeDataSourceImpl implements HomeDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final String userCollection = 'users';

  HomeDataSourceImpl({required this.db, required this.auth});

  @override
  Future<UserModel> getUserDataByEmail(String email) async {
    final docRef = db
        .collection(userCollection)
        .where("email", isEqualTo: email);
    final res = await docRef.get();
    return UserModel.fromJson(res.docs.first.data(), res.docs.first.reference);
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
    await auth.currentUser?.delete();
    SharedPreferenceManager().clearEmailAccount();
  }
}
