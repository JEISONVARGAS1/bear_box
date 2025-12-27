import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/core/errors/failure.dart';

abstract class CreateUserRepository {
  Future<Either<Failure, bool>> createUser(UserModel user, UserMedicalData medicalData);
  Future<Either<Failure, bool>> generateMedicalData(UserModel user, UserMedicalData medicalData);
} 