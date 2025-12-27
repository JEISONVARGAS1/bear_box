import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/subscriptions/domain/repositories/subscriptions_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class SubscriptionsRepositoriesImpl implements SubscriptionsRepositories {
  final FirebaseFirestore _firestore;

  SubscriptionsRepositoriesImpl({required FirebaseFirestore db})
    : _firestore = db;

  @override
  Stream<List<SubscriptionModel>> getAllSubscriptions() {
    final DateTime now = DateTime.now();
    final DateTime startOfMonth = DateTime(now.year, now.month, 1);
    final DateTime startOfNextMonth = (now.month == 12)
        ? DateTime(now.year + 1, 1, 1)
        : DateTime(now.year, now.month + 1, 1);

    return _firestore
        .collection('subscriptionCollection')
        .where('date_created', isGreaterThanOrEqualTo: startOfMonth)
        .where('date_created', isLessThan: startOfNextMonth)
        .orderBy('date_created', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => SubscriptionModel.fromJson(doc.data(), doc.reference),
              )
              .toList(),
        );
  }

  @override
  Stream<List<SubscriptionModel>> getActiveSubscriptions() {
    return _firestore
        .collection('subscriptionCollection')
        .where('end_date', isGreaterThanOrEqualTo: DateTime.now())
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => SubscriptionModel.fromJson(doc.data(), doc.reference),
              )
              .toList(),
        );
  }

  @override
  Stream<List<UserModel>> getAllUsers() {
    return _firestore
        .collection('users')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => UserModel.fromJson(doc.data(), doc.reference))
              .toList(),
        );
  }

  @override
  Future<void> createSubscription(SubscriptionModel subscription) async {
    await _firestore.collection('subscriptions').add(subscription.toJson());
  }

  @override
  Future<void> updateSubscription(SubscriptionModel subscription) async {
    await _firestore
        .collection('subscriptions')
        .doc(subscription.userRef.id)
        .update(subscription.toJson());
  }

  @override
  Future<void> deleteSubscription(String subscriptionId) async {
    await _firestore.collection('subscriptions').doc(subscriptionId).delete();
  }
}
