import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class SubscriptionModel {
  final double price;
  final bool isActive;
  final String? notes;
  final DateTime endDate;
  final DateTime startDate;
  final DateTime dateCreated;
  final DocumentReference? ref;
  final DocumentReference userRef;
  final String name;
  final String email;

  SubscriptionModel({
    this.ref,
    this.notes,
    required this.email,
    required this.name,
    required this.price,
    this.isActive = true,
    required this.userRef,
    required this.endDate,
    required this.startDate,
    required this.dateCreated,
  });

  factory SubscriptionModel.fromJson(
    Map<String, dynamic> json,
    DocumentReference ref,
  ) {
    return SubscriptionModel(
      ref: ref,
      notes: json['notes'] as String?,
      isActive: json['is_active'] ?? true,
      price: (json['price'] as num).toDouble(),
      userRef: json['user_ref'] as DocumentReference,
      endDate: (json['end_date'] as Timestamp).toDate(),
      startDate: (json['start_date'] as Timestamp).toDate(),
      dateCreated: (json['date_created'] as Timestamp).toDate(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
    );
  }

  factory SubscriptionModel.fromUser(UserModel user) {
    late DateTime endDate = user.dateSubscription!.copyWith(
      month: user.dateSubscription!.month + 1,
    );

    if (user.priceSubscription <= 5001) endDate = user.dateSubscription!;

    return SubscriptionModel(
      isActive: true,
      name: user.name,
      endDate: endDate,
      email: user.email,
      userRef: user.id!,
      dateCreated: DateTime.now(),
      price: user.priceSubscription,
      startDate: user.dateSubscription!,
    );
  }

  factory SubscriptionModel.create({
    String? notes,
    required double price,
    required DateTime startDate,
    required DocumentReference userRef,
    required String name,
    required String email,
  }) {
    late DateTime endDate = startDate.copyWith(month: startDate.month + 1);

    if (price == 5000) endDate = startDate;

    return SubscriptionModel(
      price: price,
      notes: notes,
      isActive: true,
      userRef: userRef,
      endDate: endDate,
      startDate: startDate,
      dateCreated: DateTime.now(),
      name: name,
      email: email,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'notes': notes,
      'user_ref': userRef,
      'is_active': isActive,
      'end_date': Timestamp.fromDate(endDate),
      'start_date': Timestamp.fromDate(startDate),
      'date_created': Timestamp.fromDate(dateCreated),
      'name': name,
      'email': email,
    };
  }

  // Método copyWith para crear copias modificadas
  SubscriptionModel copyWith({
    String? id,
    String? name,
    double? price,
    String? notes,
    String? email,
    bool? isActive,
    DateTime? endDate,
    DateTime? startDate,
    DateTime? dateCreated,
    DocumentReference? ref,
    DocumentReference? userRef,
  }) {
    return SubscriptionModel(
      ref: ref ?? this.ref,
      notes: notes ?? this.notes,
      price: price ?? this.price,
      endDate: endDate ?? this.endDate,
      userRef: userRef ?? this.userRef,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      dateCreated: dateCreated ?? this.dateCreated,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
