import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/feature/login/data/data_source/login_data_source.dart';
import 'package:bearbox/feature/login/domain/repositories/login_repositories.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({required this.loginDataSource});

  final LoginDataSource loginDataSource;

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final result = await loginDataSource.logIn(email, password);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData(String id) async {
    try {
      final result = await loginDataSource.getUserData(id);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, void>> saveHiveUser(UserModel user) async {
    try {
      final result = await loginDataSource.saveHiveUser(user);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }
}
