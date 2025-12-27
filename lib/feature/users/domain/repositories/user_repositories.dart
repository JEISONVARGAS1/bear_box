import 'package:bearbox/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, Stream<List<UserModel>>>> getAllUserData();
  Future<Either<Failure, void>> deleteUser(String userId);
}
