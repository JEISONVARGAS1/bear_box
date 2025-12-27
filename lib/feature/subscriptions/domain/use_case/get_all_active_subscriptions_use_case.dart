import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/subscriptions/domain/repositories/subscriptions_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllActiveSubscriptionsUseCase
    implements BaseUseCase<Stream<List<SubscriptionModel>>, NoParams> {
  final SubscriptionsRepositories subscriptionsRepositories;

  GetAllActiveSubscriptionsUseCase({required this.subscriptionsRepositories});

  @override
  Future<Either<Failure, Stream<List<SubscriptionModel>>>> call(
    NoParams params,
  ) async {
    try {
      final result = subscriptionsRepositories.getActiveSubscriptions();
      return Right(result);
    } catch (e) {
      return Left(UpdateUserFailure(message: e.toString()));
    }
  }
}
