import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

abstract class UpdateUserRepositories {
  Future<Either<Failure, bool>> updateWorkout(UserModel user);
  Future<Either<Failure, bool>> updateExistedWorkoutUseCase(
    SubscriptionModel user,
  );
  Future<Either<Failure, List<SubscriptionModel>>> getHistorySubscription(
    UserModel user,
  );

  Future<Either<Failure, bool>> setSubscription(UserModel user);
}
