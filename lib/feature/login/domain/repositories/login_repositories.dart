import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserModel>> getUserData(String id);

  Future<Either<Failure, void>> saveHiveUser(UserModel user);

  Future<Either<Failure, User>> login(String password, String email);
}
