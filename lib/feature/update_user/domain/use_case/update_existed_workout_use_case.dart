import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/update_user/domain/repositories/update_user_repositories.dart';
import 'package:dartz/dartz.dart';

class UpdateExistedWorkoutUseCase extends BaseUseCase<bool, SubscriptionModel> {
  UpdateExistedWorkoutUseCase({required this.updateUserRepository});

  final UpdateUserRepositories updateUserRepository;

  @override
  Future<Either<Failure, bool>> call(SubscriptionModel user) =>
      updateUserRepository.updateExistedWorkoutUseCase(user);
}
