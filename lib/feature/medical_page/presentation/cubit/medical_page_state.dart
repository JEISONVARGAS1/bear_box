part of 'medical_page_cubit.dart';

class MedicalPageState {
  final bool isLoading;
  final String hasPain;
  final String hasDiseases;
  final GlobalKey<FormState> formKey;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController bmiController;
  final TextEditingController fatPercentageController;
  final TextEditingController musclePercentageController;
  final TextEditingController rmKcalController;
  final TextEditingController bodyAgeController;
  final TextEditingController visceralFatController;
  final TextEditingController restingHeartRateController;
  final TextEditingController so2PercentageController;
  final TextEditingController systolicPressureController;
  final TextEditingController diastolicPressureController;
  final TextEditingController medicalObservationController;
  final UserModel user;

  const MedicalPageState({
    required this.isLoading,
    required this.hasPain,
    required this.hasDiseases,
    required this.formKey,
    required this.heightController,
    required this.weightController,
    required this.bmiController,
    required this.fatPercentageController,
    required this.musclePercentageController,
    required this.rmKcalController,
    required this.bodyAgeController,
    required this.visceralFatController,
    required this.restingHeartRateController,
    required this.so2PercentageController,
    required this.systolicPressureController,
    required this.diastolicPressureController,
    required this.medicalObservationController,
    required this.user,
  });

  factory MedicalPageState.init({required UserModel user}) => MedicalPageState(
    isLoading: false,
    hasPain: "NO",
    hasDiseases: "NO",
    user: user,
    formKey: GlobalKey<FormState>(),
    heightController: TextEditingController(),
    weightController: TextEditingController(),
    bmiController: TextEditingController(),
    fatPercentageController: TextEditingController(),
    musclePercentageController: TextEditingController(),
    rmKcalController: TextEditingController(),
    bodyAgeController: TextEditingController(),
    visceralFatController: TextEditingController(),
    restingHeartRateController: TextEditingController(),
    so2PercentageController: TextEditingController(),
    systolicPressureController: TextEditingController(),
    diastolicPressureController: TextEditingController(),
    medicalObservationController: TextEditingController(),
  );

  MedicalPageState copyWith({
    bool? isLoading,
    String? hasPain,
    String? hasDiseases,
  }) => MedicalPageState(
    isLoading: isLoading ?? this.isLoading,
    hasPain: hasPain ?? this.hasPain,
    hasDiseases: hasDiseases ?? this.hasDiseases,
    formKey: formKey,
    heightController: heightController,
    weightController: weightController,
    bmiController: bmiController,
    fatPercentageController: fatPercentageController,
    musclePercentageController: musclePercentageController,
    rmKcalController: rmKcalController,
    bodyAgeController: bodyAgeController,
    visceralFatController: visceralFatController,
    restingHeartRateController: restingHeartRateController,
    so2PercentageController: so2PercentageController,
    systolicPressureController: systolicPressureController,
    diastolicPressureController: diastolicPressureController,
    medicalObservationController: medicalObservationController,
    user: user,
  );
}
