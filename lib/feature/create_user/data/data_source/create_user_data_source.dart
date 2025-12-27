import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class CreateUserDataSource {
  Future<bool> createUser(UserModel user, UserMedicalData medicalData);
  Future<bool> generateMedicalData(UserModel user, UserMedicalData medicalData);
}

class CreateUserDataSourceImpl implements CreateUserDataSource {
  final FirebaseFirestore db;
  final String userCollection = 'users';
  final String medicalDataCollection = 'medical_data';

  CreateUserDataSourceImpl({required this.db});

  @override
  Future<bool> createUser(UserModel user, UserMedicalData medicalData) async {
    final docRef = await db.collection(userCollection).add(user.toJson());

    final historyData = Map<String, dynamic>.from(user.toJson());
    historyData['history_creation_date'] = DateTime.now();

    await docRef.collection("history").doc().set(historyData);

    await docRef.collection(medicalDataCollection).add(medicalData.toJson());

    if (user.priceSubscription > 0) {
      await _setSubscription(user.copyWith(id: docRef));
    }

    return true;
  }

  @override
  Future<bool> generateMedicalData(
    UserModel user,
    UserMedicalData medicalData,
  ) async {
    final docRef = await db.collection(userCollection).add(user.toJson());

    final historyData = Map<String, dynamic>.from(user.toJson());
    historyData['history_creation_date'] = DateTime.now();

    await docRef.collection("history").doc().set(historyData);

    await docRef.collection(medicalDataCollection).add(medicalData.toJson());

    return true;
  }

  Future<bool> _setSubscription(UserModel user) async {
    final subscription = SubscriptionModel.fromUser(user);

    final query = db
        .collection("subscriptionCollection")
        .where("user_ref", isEqualTo: user.id)
        .where("end_date", isGreaterThanOrEqualTo: DateTime.now())
        .where("start_date", isLessThanOrEqualTo: DateTime.now());

    final ref = await query.get();

    if (ref.docs.isEmpty) {
      await db.collection("subscriptionCollection").add(subscription.toJson());
    } else {
      await ref.docs.first.reference.update(subscription.toJson());
    }

    return true;
  }
}
