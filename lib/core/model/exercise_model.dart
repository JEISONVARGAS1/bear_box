import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseModel {
  final String url;
  final String name;
  final String description;
  final DateTime dateCreate;
  final DocumentReference? id;
  final List<DocumentReference> muscleGroups;
  final List<DocumentReference> workoutPrograms;

  ExerciseModel({
    this.id,
    required this.url,
    required this.name,
    required this.dateCreate,
    required this.description,
    required this.muscleGroups,
    required this.workoutPrograms,
  });

  ExerciseModel copyWith({
    String? url,
    String? name,
    String? description,
    DateTime? dateCreate,
    DocumentReference? id,
    List<DocumentReference>? type,
    List<DocumentReference>? muscleGroups,
    List<DocumentReference>? workoutPrograms,
  }) => ExerciseModel(
    id: id ?? this.id,
    url: url ?? this.url,
    name: name ?? this.name,
    dateCreate: dateCreate ?? this.dateCreate,
    description: description ?? this.description,
    muscleGroups: muscleGroups ?? this.muscleGroups,
    workoutPrograms: workoutPrograms ?? this.workoutPrograms,
  );

  factory ExerciseModel.fromJson(json, DocumentReference ref) => ExerciseModel(
    id: ref,
    url: json["url"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    dateCreate: json["date_create"] != null ? json["date_create"].toDate() : DateTime.now(),
    muscleGroups: json["muscle_groups"] != null ? List<DocumentReference>.from(json["muscle_groups"].map((x) => x)) : [],
    workoutPrograms: json["workout_programs"] != null ? List<DocumentReference>.from(json["workout_programs"].map((x) => x)) : [],
  );

  factory ExerciseModel.fromIa(json) => ExerciseModel(
    url: json["url"],
    name: json["name"],
    description: json["date_create"],
    dateCreate: json["date_create"] != null ? json["dateCreate"].toDate() : DateTime.now(),
    muscleGroups:json["muscle_groups"] != null ? List<DocumentReference>.from(json["muscle_groups"].map((x) => x)) : [],
    workoutPrograms: json["workout_programs"] != null ? List<DocumentReference>.from(json["workout_programs"].map((x) => x),) : [],
  );

  factory ExerciseModel.init() => ExerciseModel(
    url: "",
    name: "",
    description: "",
    muscleGroups: [],
    workoutPrograms: [],
    dateCreate: DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "name": name,
    "date_create": dateCreate,
    "description": description,
    "muscle_groups": List<dynamic>.from(muscleGroups.map((x) => x)),
    "workout_programs": List<dynamic>.from(workoutPrograms.map((x) => x)),
  };

  Map<String, dynamic> toJsonIa() => {
    "url": url,
    "name": name,
    "id": id!.id,
    "date_create": dateCreate,
    "description": description,
    "muscle_groups": List<dynamic>.from(muscleGroups.map((x) => x)),
    "workout_programs": List<dynamic>.from(workoutPrograms.map((x) => x)),
  };
}
