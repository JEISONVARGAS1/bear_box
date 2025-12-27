import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String image;
  final String email;
  final String documentId;
  final double height;
  final double weight;
  final String gender;
  final DateTime birthday;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final DocumentReference? id;
  final DocumentReference? workoutRef;
  final bool isAdmin;

  UserModel({
    this.id,
    this.workoutRef,
    required this.name,
    required this.email,
    required this.image,
    required this.documentId,
    required this.height,
    required this.weight,
    required this.gender,
    required this.birthday,
    required this.dateCreate,
    required this.dateUpdate,
    this.isAdmin = false,
  });

  UserModel copyWith({
    String? name,
    String? image,
    String? email,
    String? documentId,
    double? height,
    double? weight,
    String? gender,
    DateTime? birthday,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    DocumentReference? workoutRef,
    bool? isAdmin,
  }) => UserModel(
    id: id,
    name: name ?? this.name,
    image: image ?? this.image,
    email: email ?? this.email,
    documentId: documentId ?? this.documentId,
    height: height ?? this.height,
    weight: weight ?? this.weight,
    gender: gender ?? this.gender,
    birthday: birthday ?? this.birthday,
    dateCreate: dateCreate ?? this.dateCreate,
    workoutRef: workoutRef ?? this.workoutRef,
    dateUpdate: dateUpdate ?? this.dateUpdate,
    isAdmin: isAdmin ?? this.isAdmin,
  );

  factory UserModel.fromJson(json, DocumentReference id) => UserModel(
    id: id,
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    image: json["image"] ?? "",
    documentId: json["document_id"] ?? "",
    gender: json["gender"] ?? "MALE",
    workoutRef: json["workout_ref"],
    height: json["height"]?.toDouble() ?? 0.0,
    weight: json["weight"]?.toDouble() ?? 0.0,
    birthday: json["birthday"]?.toDate() ?? DateTime.now(),
    dateCreate: json["date_create"]?.toDate() ?? DateTime.now(),
    dateUpdate: json["date_update"]?.toDate() ?? DateTime.now(),
    isAdmin: json["is_admin"] ?? false,
  );

  factory UserModel.init() => UserModel(
    name: "",
    email: "",
    image: "",
    documentId: "",
    gender: "",
    weight: 80,
    height: 1.70,
    birthday: DateTime.now(),
    dateCreate: DateTime.now(),
    dateUpdate: DateTime.now(),
    isAdmin: false,
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "email": email,
    "document_id": documentId,
    "gender": gender,
    "height": height,
    "weight": weight,
    "birthday": birthday,
    "date_create": dateCreate,
    "date_update": dateUpdate,
    "workout_ref": workoutRef,
    "is_admin": isAdmin,
  };
}
