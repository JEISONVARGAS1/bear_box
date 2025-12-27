import 'package:bearbox/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, UserModel>> getUserDataByEmail(String email);
}
