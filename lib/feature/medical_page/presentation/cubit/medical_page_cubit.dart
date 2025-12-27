import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/medical_page/domain/use_case/save_medical_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

part 'medical_page_state.dart';

class MedicalPageCubit extends Cubit<MedicalPageState> {
  final SaveMedicalDataUseCase _saveMedicalDataUseCase;

  MedicalPageCubit({required SaveMedicalDataUseCase saveMedicalDataUseCase})
    : _saveMedicalDataUseCase = saveMedicalDataUseCase,
      super(MedicalPageState.init(user: UserModel.init()));

  void init(BuildContext context, UserModel user) {
    emit(MedicalPageState.init(user: user));
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

  void selectDiseases(String diseases) {
    emit(state.copyWith(hasDiseases: diseases));
  }

  void selectPain(String pain) {
    emit(state.copyWith(hasPain: pain));
  }

  void saveMedicalData(BuildContext context) async {
    if (!state.formKey.currentState!.validate()) return;

    emit(state.copyWith(isLoading: true));
    final medicalData = _generateMedicalData();
    final params = SaveMedicalDataParams(
      user: state.user,
      medicalData: medicalData,
    );
    final resultDb = await _saveMedicalDataUseCase(params);

    resultDb.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (bool item) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(
          context,
          isSuccess: true,
          message: "Datos médicos guardados exitosamente",
        );
        context.pop();
      },
    );
  }

  UserMedicalData _generateMedicalData() {
    return UserMedicalData(
      bmi: double.tryParse(state.bmiController.text),
      fatPercentage: double.tryParse(state.fatPercentageController.text),
      musclePercentage: double.tryParse(state.musclePercentageController.text),
      rmKcal: double.tryParse(state.rmKcalController.text),
      bodyAge: int.tryParse(state.bodyAgeController.text),
      visceralFat: double.tryParse(state.visceralFatController.text),
      restingHeartRate: int.tryParse(state.restingHeartRateController.text),
      so2Percentage: double.tryParse(state.so2PercentageController.text),
      systolicPressure: int.tryParse(state.systolicPressureController.text),
      diastolicPressure: int.tryParse(state.diastolicPressureController.text),
      hasDiseases: state.hasDiseases,
      hasPain: state.hasPain,
      medicalObservation: state.medicalObservationController.text,
      weight: double.tryParse(state.weightController.text),
      height: double.tryParse(state.heightController.text),
      dateCreate: DateTime.now(),
      dateUpdate: DateTime.now(),
    );
  }

  @override
  Future<void> close() {
    state.heightController.dispose();
    state.weightController.dispose();
    state.bmiController.dispose();
    state.fatPercentageController.dispose();
    state.musclePercentageController.dispose();
    state.rmKcalController.dispose();
    state.bodyAgeController.dispose();
    state.visceralFatController.dispose();
    state.restingHeartRateController.dispose();
    state.so2PercentageController.dispose();
    state.systolicPressureController.dispose();
    state.diastolicPressureController.dispose();
    state.medicalObservationController.dispose();

    return super.close();
  }
}
