import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/feature/login/domain/repositories/login_repositories.dart';

class SaveHiveUserUseCase extends BaseUseCase<void, UserModel> {
  SaveHiveUserUseCase({required this.loginRepository});

  final LoginRepository loginRepository;

  @override
  Future<Either<Failure, void>> call(UserModel params) =>
      loginRepository.saveHiveUser(params);
}
