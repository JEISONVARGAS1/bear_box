import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/feature/login/domain/repositories/login_repositories.dart';

class GetUserDataUseCase extends BaseUseCase<UserModel, String> {
  GetUserDataUseCase({required this.loginRepository});

  final LoginRepository loginRepository;

  @override
  Future<Either<Failure, UserModel>> call(String params) =>
      loginRepository.getUserData(params);
}
