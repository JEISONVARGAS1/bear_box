import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/feature/create_user/data/data_source/create_user_data_source.dart';
import 'package:bearbox/feature/create_user/domain/repositories/create_user_repositories.dart';

class CreateUserRepositoryImpl implements CreateUserRepository {
  CreateUserRepositoryImpl({required this.createUserDataSource});

  final CreateUserDataSource createUserDataSource;

  @override
  Future<Either<Failure, bool>> createUser(UserModel user, UserMedicalData medicalData) async {
    try {
      final result = await createUserDataSource.createUser(user, medicalData);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, bool>> generateMedicalData(UserModel user, UserMedicalData medicalData) async {
    try {
      final result = await createUserDataSource.generateMedicalData(user, medicalData);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }
} 