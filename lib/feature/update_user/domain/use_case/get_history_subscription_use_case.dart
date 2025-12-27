import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/update_user/domain/repositories/update_user_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class GetHistorySubscriptionUseCase
    extends BaseUseCase<List<SubscriptionModel>, UserModel> {
  GetHistorySubscriptionUseCase({required this.updateUserRepository});

  final UpdateUserRepositories updateUserRepository;

  @override
  Future<Either<Failure, List<SubscriptionModel>>> call(UserModel user) =>
      updateUserRepository.getHistorySubscription(user);
}
