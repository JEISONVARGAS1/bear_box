import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/feature/update_user/domain/repositories/update_user_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class SetSubscriptionUseCase extends BaseUseCase<bool, UserModel> {
  SetSubscriptionUseCase({required this.updateUserRepository});

  final UpdateUserRepositories updateUserRepository;

  @override
  Future<Either<Failure, bool>> call(UserModel user) =>
      updateUserRepository.setSubscription(user);
}
