import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class MedicalPageRepository {
  Future<Either<Failure, bool>> saveMedicalData(
    UserModel user,
    UserMedicalData medicalData,
  );
  Future<Either<Failure, List<UserMedicalData>>> getMedicalHistory(
    UserModel user,
  );
}
