import 'package:bearbox/core/model/subscription_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SubscriptionTableModel {
  final String id;
  final double price;
  final bool isActive;
  final double progress;
  final String userName;
  final String userEmail;
  final DateTime endDate;
  final String userPhoto;
  final int daysRemaining;
  final DateTime startDate;
  final DocumentReference userRef;

  SubscriptionTableModel({
    required this.id,
    required this.price,
    required this.endDate,
    required this.userRef,
    required this.isActive,
    required this.progress,
    required this.userName,
    required this.userEmail,
    required this.userPhoto,
    required this.startDate,
    required this.daysRemaining,
  });

  factory SubscriptionTableModel.fromSubscriptionModel(
    SubscriptionModel subscription,
    String userPhoto,
  ) {
    final now = DateTime.now();
    final isExpired = now.isAfter(subscription.endDate);
    final isActive =
        subscription.isActive &&
        now.isAfter(subscription.startDate) &&
        !isExpired;

    final daysRemaining = isExpired
        ? 0
        : subscription.endDate.difference(now).inDays;

    final totalDays = subscription.endDate
        .difference(subscription.startDate)
        .inDays;
    final elapsedDays = now.difference(subscription.startDate).inDays;

    double progress;
    if (totalDays <= 0) {
      progress = 0.0;
    } else if (elapsedDays <= 0) {
      progress = 0.0;
    } else if (elapsedDays >= totalDays) {
      progress = 1.0;
    } else {
      progress = elapsedDays / totalDays;
    }

    return SubscriptionTableModel(
      isActive: isActive,
      progress: progress,
      userPhoto: userPhoto,
      price: subscription.price,
      id: subscription.userRef.id,
      userName: subscription.name,
      daysRemaining: daysRemaining,
      endDate: subscription.endDate,
      userRef: subscription.userRef,
      userEmail: subscription.email,
      startDate: subscription.startDate,
    );
  }

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';
  String get formattedStartDate =>
      '${startDate.day}/${startDate.month}/${startDate.year}';
  String get formattedEndDate =>
      '${endDate.day}/${endDate.month}/${endDate.year}';
  String get formattedProgress => '${(progress * 100).toInt()}%';
}
