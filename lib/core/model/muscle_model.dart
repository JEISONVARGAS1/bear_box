import 'package:cloud_firestore/cloud_firestore.dart';

class MusclesModel {
  final String name;
  final String key;
  final DocumentReference? id;

  MusclesModel({
    this.id,
    required this.key,
    required this.name,
  });

  MusclesModel copyWith({
    String? key,
    String? name,
    DocumentReference? id,
  }) =>
      MusclesModel(
        id: id ?? this.id,
        key: key ?? this.key,
        name: name ?? this.name,
      );

  factory MusclesModel.fromJson(json, DocumentReference id) =>
      MusclesModel(
        id: id,
        name: json["name"],
        key: json["key"] ?? "",
      );

  factory MusclesModel.init() => MusclesModel(name: "", key: "");

  Map<String, dynamic> toJson() => {
        "key": key,
        "name": name,
      };
}
