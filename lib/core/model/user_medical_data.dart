import 'package:cloud_firestore/cloud_firestore.dart';

class UserMedicalData {
  final double? bmi;
  final int? bodyAge;
  final String hasPain;
  final double? rmKcal;
  final String hasDiseases;
  final DateTime dateCreate;
  final DateTime dateUpdate;
  final double? visceralFat;
  final double? so2Percentage;
  final double? fatPercentage;
  final DocumentReference? id;
  final int? systolicPressure;
  final int? restingHeartRate;
  final int? diastolicPressure;
  final double? musclePercentage;
  final String medicalObservation;
  final double? weight;
  final double? height;

  UserMedicalData({
    this.id,
    this.bmi,
    this.rmKcal,
    this.bodyAge,
    this.visceralFat,
    this.fatPercentage,
    this.so2Percentage,
    this.musclePercentage,
    required this.hasPain,
    this.restingHeartRate,
    this.systolicPressure,
    this.diastolicPressure,
    required this.dateCreate,
    required this.dateUpdate,
    required this.hasDiseases,
    required this.medicalObservation,
    this.weight,
    this.height,
  });

  UserMedicalData copyWith({
    double? bmi,
    int? bodyAge,
    double? rmKcal,
    String? hasPain,
    double? visceralFat,
    String? hasDiseases,
    DateTime? dateCreate,
    DateTime? dateUpdate,
    int? restingHeartRate,
    double? fatPercentage,
    double? so2Percentage,
    int? systolicPressure,
    DocumentReference? id,
    int? diastolicPressure,
    double? musclePercentage,
    String? medicalObservation,
    double? weight,
    double? height,
  }) => UserMedicalData(
    id: id ?? this.id,
    bmi: bmi ?? this.bmi,
    rmKcal: rmKcal ?? this.rmKcal,
    bodyAge: bodyAge ?? this.bodyAge,
    hasPain: hasPain ?? this.hasPain,
    dateUpdate: dateUpdate ?? this.dateUpdate,
    dateCreate: dateCreate ?? this.dateCreate,
    hasDiseases: hasDiseases ?? this.hasDiseases,
    visceralFat: visceralFat ?? this.visceralFat,
    fatPercentage: fatPercentage ?? this.fatPercentage,
    so2Percentage: so2Percentage ?? this.so2Percentage,
    musclePercentage: musclePercentage ?? this.musclePercentage,
    restingHeartRate: restingHeartRate ?? this.restingHeartRate,
    systolicPressure: systolicPressure ?? this.systolicPressure,
    diastolicPressure: diastolicPressure ?? this.diastolicPressure,
    medicalObservation: medicalObservation ?? this.medicalObservation,
    weight: weight ?? this.weight,
    height: height ?? this.height,
  );

  factory UserMedicalData.fromJson(json, DocumentReference id) =>
      UserMedicalData(
        id: id,
        bmi: json["bmi"]?.toDouble(),
        hasPain: json["has_pain"] ?? "NO",
        bodyAge: json["body_age"]?.toInt(),
        rmKcal: json["rm_kcal"]?.toDouble(),
        hasDiseases: json["has_diseases"] ?? "NO",
        visceralFat: json["visceral_fat"]?.toDouble(),
        so2Percentage: json["so2_percentage"]?.toDouble(),
        fatPercentage: json["fat_percentage"]?.toDouble(),
        systolicPressure: json["systolic_pressure"]?.toInt(),
        restingHeartRate: json["resting_heart_rate"]?.toInt(),
        medicalObservation: json["medical_observation"] ?? "",
        diastolicPressure: json["diastolic_pressure"]?.toInt(),
        musclePercentage: json["muscle_percentage"]?.toDouble(),
        dateCreate: json["date_create"]?.toDate() ?? DateTime.now(),
        dateUpdate: json["date_update"]?.toDate() ?? DateTime.now(),
        weight: json["weight"]?.toDouble(),
        height: json["height"]?.toDouble(),
      );

  factory UserMedicalData.init() => UserMedicalData(
    bmi: null,
    rmKcal: null,
    bodyAge: null,
    hasPain: "NO",
    visceralFat: null,
    hasDiseases: "NO",
    fatPercentage: null,
    so2Percentage: null,
    musclePercentage: null,
    restingHeartRate: null,
    medicalObservation: "",
    systolicPressure: null,
    diastolicPressure: null,
    dateCreate: DateTime.now(),
    dateUpdate: DateTime.now(),
    weight: null,
    height: null,
  );

  Map<String, dynamic> toJson() => {
    "bmi": bmi,
    "rm_kcal": rmKcal,
    "body_age": bodyAge,
    "has_pain": hasPain,
    "date_create": dateCreate,
    "date_update": dateUpdate,
    "visceral_fat": visceralFat,
    "has_diseases": hasDiseases,
    "so2_percentage": so2Percentage,
    "fat_percentage": fatPercentage,
    "muscle_percentage": musclePercentage,
    "resting_heart_rate": restingHeartRate,
    "systolic_pressure": systolicPressure,
    "diastolic_pressure": diastolicPressure,
    "medical_observation": medicalObservation,
    "weight": weight,
    "height": height,
  };
}
