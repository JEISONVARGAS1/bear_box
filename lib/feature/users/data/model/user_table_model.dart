import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class UserTableModel {
  final String name;
  final String photo;
  final String phone;
  final String email;
  final String? documentId;
  final DocumentReference? id;
  final double priceSubscription;
  final DateTime? dateSubscription;

  UserTableModel({
    this.id,
    this.documentId,
    required this.name,
    required this.photo,
    required this.phone,
    required this.email,
    this.dateSubscription,
    required this.priceSubscription,
  });

  UserTableModel copyWith({
    String? name,
    String? photo,
    String? phone,
    String? email,
    String? documentId,
    DocumentReference? id,
    double? priceSubscription,
    DateTime? dateSubscription,
  }) => UserTableModel(
    id: id ?? this.id,
    name: name ?? this.name,
    photo: photo ?? this.photo,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    documentId: documentId ?? this.documentId,
    dateSubscription: dateSubscription ?? this.dateSubscription,
    priceSubscription: priceSubscription ?? this.priceSubscription,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "phone": phone,
    "email": email,
    "documentId": documentId,
    "dateSubscription": dateSubscription,
    "priceSubscription": priceSubscription,
  };

  factory UserTableModel.fromJson(Map<String, dynamic> json) => UserTableModel(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    phone: json["phone"],
    email: json["email"],
    documentId: json["documentId"],
    dateSubscription: json["dateSubscription"],
    priceSubscription: json["priceSubscription"],
  );

  factory UserTableModel.fromUserModel(UserModel user) => UserTableModel(
    id: user.id!,
    name: user.name,
    photo: user.image,
    phone: user.phone,
    email: user.email,
    documentId: user.documentId,
    dateSubscription: user.dateSubscription,
    priceSubscription: user.priceSubscription,
  );
}
