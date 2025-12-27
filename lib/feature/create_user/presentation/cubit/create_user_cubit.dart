import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/create_user/domain/use_case/create_user_use_case.dart';
import 'package:bearbox/feature/create_user/domain/use_case/generate_medical_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

part 'create_user_state.dart';

class CreateUserCubit extends Cubit<CreateUserState> {
  final CreateUserUseCase _createUserUseCase;
  final GenerateMedicalDataUseCase _generateMedicalDataUseCase;

  CreateUserCubit({
    required CreateUserUseCase createUserUseCase,
    required GenerateMedicalDataUseCase generateMedicalDataUseCase,
  }) : _createUserUseCase = createUserUseCase,
       _generateMedicalDataUseCase = generateMedicalDataUseCase,
       super(CreateUserState.init());

  void init(BuildContext context) async {
    // Inicializar con valores por defecto
  }

  String? validateName(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    if (newText.length < 4) return "Mínimo 4 caracteres";
    return null;
  }

  String? validateEmail(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    if (!newText.contains('@')) return "Email inválido";
    return null;
  }

  String? validateDocumentId(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    if (newText.length < 8) return "Documento de identidad inválido";
    return null;
  }

  String? validateHeight(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    final height = double.tryParse(newText);
    if (height == null || height <= 0) return "Altura inválida";
    return null;
  }

  String? validateWeight(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    final weight = double.tryParse(newText);
    if (weight == null || weight <= 0) return "Peso inválido";
    return null;
  }

  void createUser(BuildContext context) async {
    if (!state.formKey.currentState!.validate()) return;

    emit(state.copyWith(isLoading: true));
    final user = _generateUser();
    final medicalData = _generateMedicalData();
    final params = CreateUserParams(user: user, medicalData: medicalData);
    final resultDb = await _createUserUseCase(params);

    resultDb.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (bool item) {
        context.pop();
      },
    );
  }

  void selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now().subtract(const Duration(days: 15)),
    );

    if (date == null) return;

    final dateFormat = DateFormat('dd-MMM-yyyy', 'es');
    state.subscriptionDateController.text = dateFormat.format(date);

    emit(state.copyWith(dateSubscription: date));
  }

  void selectBirthday(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 36500)),
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
    );

    if (date == null) return;

    final dateFormat = DateFormat('dd-MMM-yyyy', 'es');
    state.birthdayController.text = dateFormat.format(date);

    emit(state.copyWith(birthday: date));
  }

  void selectGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  void selectPriceSubscription(String price) {
    final priceDouble = double.parse(
      price.replaceAll("\$", "").replaceAll(".", ""),
    );
    state.priceSubscriptionController.text = priceDouble.toString();
    emit(state.copyWith(priceSubscription: priceDouble));
  }

  void selectDiseases(String diseases) {
    emit(state.copyWith(hasDiseases: diseases));
  }

  void selectPain(String pain) {
    emit(state.copyWith(hasPain: pain));
  }

  UserModel _generateUser() {
    return UserModel(
      image: "",
      isAdmin: false,
      gender: state.gender,
      birthday: state.birthday,
      dateCreate: DateTime.now(),
      dateUpdate: DateTime.now(),
      name: state.nameController.text,
      email: state.emailController.text,
      phone: state.phoneController.text,
      address: state.addressController.text,
      dateSubscription: state.dateSubscription,
      priceSubscription: state.priceSubscription,
      documentId: state.documentIdController.text,
      addressDescription: state.addressDescriptionController.text,
    );
  }

  UserMedicalData _generateMedicalData() {
    return UserMedicalData(
      hasPain: state.hasPain,
      dateUpdate: DateTime.now(),
      dateCreate: DateTime.now(),
      hasDiseases: state.hasDiseases,
      bmi: double.tryParse(state.bmiController.text),
      bodyAge: int.tryParse(state.bodyAgeController.text),
      rmKcal: double.tryParse(state.rmKcalController.text),
      medicalObservation: state.medicalObservationController.text,
      visceralFat: double.tryParse(state.visceralFatController.text),
      so2Percentage: double.tryParse(state.so2PercentageController.text),
      fatPercentage: double.tryParse(state.fatPercentageController.text),
      restingHeartRate: int.tryParse(state.restingHeartRateController.text),
      systolicPressure: int.tryParse(state.systolicPressureController.text),
      diastolicPressure: int.tryParse(state.diastolicPressureController.text),
      musclePercentage: double.tryParse(state.musclePercentageController.text),
    );
  }

  handledCreateMedicalHistory(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    final medicalData = _generateMedicalData();
    final params = GenerateMedicalDataParams(
      user: state.user,
      medicalData: medicalData,
    );
    final resultDb = await _generateMedicalDataUseCase(params);

    resultDb.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (bool item) {
        context.pop();
      },
    );
  }

  @override
  Future<void> close() {
    state.bmiController.dispose();
    state.nameController.dispose();
    state.emailController.dispose();
    state.phoneController.dispose();
    state.rmKcalController.dispose();
    state.heightController.dispose();
    state.weightController.dispose();
    state.addressController.dispose();
    state.bodyAgeController.dispose();
    state.birthdayController.dispose();
    state.visceralFatController.dispose();
    state.so2PercentageController.dispose();
    state.fatPercentageController.dispose();
    state.subscriptionDateController.dispose();
    state.systolicPressureController.dispose();
    state.musclePercentageController.dispose();
    state.restingHeartRateController.dispose();
    state.priceSubscriptionController.dispose();
    state.diastolicPressureController.dispose();
    state.addressDescriptionController.dispose();
    state.medicalObservationController.dispose();

    return super.close();
  }
}
