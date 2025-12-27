import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/feature/home/data/data_source/home_data_source.dart';
import 'package:bearbox/feature/home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.homeDataSource});

  final HomeDataSource homeDataSource;

  @override
  Future<Either<Failure, UserModel>> getUserDataByEmail(String email) async {
    try {
      final result = await homeDataSource.getUserDataByEmail(email);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await homeDataSource.logout();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }
}
