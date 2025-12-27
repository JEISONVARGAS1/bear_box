import 'package:dartz/dartz.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/feature/update_user/domain/repositories/update_user_repositories.dart';

class UpdateUserUseCase extends BaseUseCase<bool, UserModel> {
  UpdateUserUseCase({required this.updateUserRepository});

  final UpdateUserRepositories updateUserRepository;

  @override
  Future<Either<Failure, bool>> call(UserModel user) =>
      updateUserRepository.updateWorkout(user);
}
