import 'package:bearbox/core/model/subscription_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class UpdateUserDataSource {
  Future<bool> updateWorkout(UserModel user);
  Future<bool> setSubscription(UserModel user);
  Future<List<SubscriptionModel>> getHistorySubscription(UserModel user);
  Future<bool> updateExistedWorkoutUseCase(SubscriptionModel subscription);
}

class UpdateUserDataSourceImpl implements UpdateUserDataSource {
  final FirebaseFirestore db;
  final FirebaseStorage storage;

  UpdateUserDataSourceImpl({required this.db, required this.storage});

  @override
  Future<bool> updateWorkout(UserModel user) async {
    await user.id!.update(user.toJson());
    final historyData = Map<String, dynamic>.from(user.toJson());
    historyData['history_creation_date'] = DateTime.now();

    await user.id!.collection("history").doc().set(historyData);

    return true;
  }

  @override
  Future<List<SubscriptionModel>> getHistorySubscription(UserModel user) async {
    final query = db
        .collection("subscriptionCollection")
        .where("user_ref", isEqualTo: user.id);

    final res = await query.get();

    final list = res.docs
        .map((e) => SubscriptionModel.fromJson(e.data(), e.reference))
        .toList();

    return list;
  }

  @override
  Future<bool> setSubscription(UserModel user) async {
    final subscription = SubscriptionModel.fromUser(user);
    await db.collection("subscriptionCollection").add(subscription.toJson());
    return true;
  }

  @override
  Future<bool> updateExistedWorkoutUseCase(
    SubscriptionModel subscription,
  ) async {
    await subscription.ref!.update(subscription.toJson());
    subscription.userRef.update({
      "date_update": DateTime.now(),
      "date_subscription": subscription.startDate,
    });
    return true;
  }
}
