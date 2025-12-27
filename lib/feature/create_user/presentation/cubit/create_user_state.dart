part of 'create_user_cubit.dart';

class CreateUserState {
  final String gender;
  final UserModel user;
  final bool isLoading;
  final String hasPain;
  final DateTime birthday;
  final String hasDiseases;
  final double priceSubscription;
  final DateTime? dateSubscription;
  final GlobalKey<FormState> formKey;
  final TextEditingController bmiController;
  final TextEditingController nameController;
  final List<UserMedicalData> medicalDataList;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController documentIdController;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final TextEditingController rmKcalController;
  final TextEditingController addressController;
  final TextEditingController bodyAgeController;
  final TextEditingController birthdayController;
  final TextEditingController visceralFatController;
  final TextEditingController fatPercentageController;
  final TextEditingController so2PercentageController;
  final TextEditingController restingHeartRateController;
  final TextEditingController musclePercentageController;
  final TextEditingController subscriptionDateController;
  final TextEditingController systolicPressureController;
  final TextEditingController diastolicPressureController;
  final TextEditingController priceSubscriptionController;
  final TextEditingController addressDescriptionController;
  final TextEditingController medicalObservationController;

  const CreateUserState({
    required this.user,
    required this.gender,
    required this.formKey,
    required this.hasPain,
    required this.birthday,
    required this.isLoading,
    required this.hasDiseases,
    required this.bmiController,
    required this.nameController,
    required this.emailController,
    required this.medicalDataList,
    required this.phoneController,
    required this.documentIdController,
    required this.dateSubscription,
    required this.heightController,
    required this.weightController,
    required this.rmKcalController,
    required this.priceSubscription,
    required this.bodyAgeController,
    required this.addressController,
    required this.birthdayController,
    required this.visceralFatController,
    required this.fatPercentageController,
    required this.so2PercentageController,
    required this.restingHeartRateController,
    required this.musclePercentageController,
    required this.subscriptionDateController,
    required this.systolicPressureController,
    required this.priceSubscriptionController,
    required this.diastolicPressureController,
    required this.addressDescriptionController,
    required this.medicalObservationController,
  });

  factory CreateUserState.init() => CreateUserState(
    isLoading: false,
    hasPain: "NO",
    gender: "MALE",
    hasDiseases: "NO",
    medicalDataList: [],
    priceSubscription: 0,
    user: UserModel.init(),
    dateSubscription: null,
    birthday: DateTime.now(),
    formKey: GlobalKey<FormState>(),
    bmiController: TextEditingController(),
    nameController: TextEditingController(),
    emailController: TextEditingController(),
    phoneController: TextEditingController(),
    documentIdController: TextEditingController(),
    heightController: TextEditingController(),
    weightController: TextEditingController(),
    rmKcalController: TextEditingController(),
    bodyAgeController: TextEditingController(),
    addressController: TextEditingController(),
    birthdayController: TextEditingController(),
    visceralFatController: TextEditingController(),
    so2PercentageController: TextEditingController(),
    fatPercentageController: TextEditingController(),
    subscriptionDateController: TextEditingController(),
    musclePercentageController: TextEditingController(),
    systolicPressureController: TextEditingController(),
    restingHeartRateController: TextEditingController(),
    priceSubscriptionController: TextEditingController(),
    diastolicPressureController: TextEditingController(),
    medicalObservationController: TextEditingController(),
    addressDescriptionController: TextEditingController(),
  );

  CreateUserState copyWith({
    String? gender,
    bool? isLoading,
    String? hasPain,
    DateTime? birthday,
    String? hasDiseases,
    double? priceSubscription,
    DateTime? dateSubscription,
  }) => CreateUserState(
    user: user,
    formKey: formKey,
    bmiController: bmiController,
    gender: gender ?? this.gender,
    nameController: nameController,
    emailController: emailController,
    phoneController: phoneController,
    documentIdController: documentIdController,
    hasPain: hasPain ?? this.hasPain,
    medicalDataList: medicalDataList,
    weightController: weightController,
    heightController: heightController,
    rmKcalController: rmKcalController,
    birthday: birthday ?? this.birthday,
    bodyAgeController: bodyAgeController,
    addressController: addressController,
    birthdayController: birthdayController,
    isLoading: isLoading ?? this.isLoading,
    visceralFatController: visceralFatController,
    hasDiseases: hasDiseases ?? this.hasDiseases,
    so2PercentageController: so2PercentageController,
    fatPercentageController: fatPercentageController,
    restingHeartRateController: restingHeartRateController,
    musclePercentageController: musclePercentageController,
    subscriptionDateController: subscriptionDateController,
    systolicPressureController: systolicPressureController,
    diastolicPressureController: diastolicPressureController,
    priceSubscriptionController: priceSubscriptionController,
    medicalObservationController: medicalObservationController,
    addressDescriptionController: addressDescriptionController,
    dateSubscription: dateSubscription ?? this.dateSubscription,
    priceSubscription: priceSubscription ?? this.priceSubscription,
  );
}
