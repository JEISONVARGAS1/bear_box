import 'package:bearbox/core/app/shared_preferences_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> getUserData(String id);

  Future<void> saveHiveUser(UserModel user);

  Future<User> logIn(String email, String password);
}

class LoginDataSourceImpl implements LoginDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;
  final String userCollection = 'users';

  LoginDataSourceImpl({required this.db, required this.auth});

  @override
  Future<User> logIn(String email, String password) async {
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user!;
  }

  @override
  Future<UserModel> getUserData(String id) async {
    final docRef = db.collection(userCollection).doc(id);
    final res = await docRef.get();
    return UserModel.fromJson(res.data(), docRef);
  }

  @override
  Future<void> saveHiveUser(UserModel user) async {
    SharedPreferenceManager().setEmailAccount(user.email);
  }
}
