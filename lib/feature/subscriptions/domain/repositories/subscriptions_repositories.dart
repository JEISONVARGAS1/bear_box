import 'package:bearbox/core/model/subscription_model.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class SubscriptionsRepositories {
  Stream<List<UserModel>> getAllUsers();
  Stream<List<SubscriptionModel>> getAllSubscriptions();
  Stream<List<SubscriptionModel>> getActiveSubscriptions();
  Future<void> createSubscription(SubscriptionModel subscription);
  Future<void> updateSubscription(SubscriptionModel subscription);
  Future<void> deleteSubscription(String subscriptionId);
}
