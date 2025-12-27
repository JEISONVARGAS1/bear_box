import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class MedicalPageDataSource {
  Future<bool> saveMedicalData(UserModel user, UserMedicalData medicalData);
  Future<List<UserMedicalData>> getMedicalHistory(UserModel user);
}

class MedicalPageDataSourceImpl implements MedicalPageDataSource {
  @override
  Future<bool> saveMedicalData(
    UserModel user,
    UserMedicalData medicalData,
  ) async {
    try {
      await user.id!.collection("medical_data").doc().set(medicalData.toJson());
      return true;
    } catch (e) {
      throw Exception('Error al guardar datos médicos: $e');
    }
  }

  @override
  Future<List<UserMedicalData>> getMedicalHistory(UserModel user) async {
    try {
      final result = await user.id!.collection("medical_data").get();
      return result.docs
          .map((e) => UserMedicalData.fromJson(e.data(), e.reference))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener historial médico: $e');
    }
  }
}
