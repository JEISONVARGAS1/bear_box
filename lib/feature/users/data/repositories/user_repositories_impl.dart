import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/feature/users/data/data_source/user_data_source.dart';
import 'package:bearbox/feature/users/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required this.userDataSource});

  final UserDataSource userDataSource;

  @override
  Future<Either<Failure, Stream<List<UserModel>>>> getAllUserData() async {
    try {
      final result = userDataSource.getAllUserData();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await userDataSource.deleteUser(userId);
      return const Right(null);
    } on FirebaseException catch (e) {
      return Left(CreateWorkoutFailure(message: e.code));
    }
  }
}
