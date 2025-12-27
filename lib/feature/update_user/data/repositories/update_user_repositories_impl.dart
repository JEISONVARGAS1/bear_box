import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/update_user/data/data_source/update_user_data_source.dart';
import 'package:bearbox/feature/update_user/domain/repositories/update_user_repositories.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class UpdateUserRepositoryImpl implements UpdateUserRepositories {
  UpdateUserRepositoryImpl({required this.updateUserDataSource});

  final UpdateUserDataSource updateUserDataSource;

  @override
  Future<Either<Failure, bool>> updateWorkout(UserModel user) async {
    try {
      final result = await updateUserDataSource.updateWorkout(user);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(UpdateUserFailure(message: e.code));
    } catch (e) {
      return Left(UpdateUserFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateExistedWorkoutUseCase(
    SubscriptionModel subscription,
  ) async {
    try {
      final result = await updateUserDataSource.updateExistedWorkoutUseCase(
        subscription,
      );
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(UpdateUserFailure(message: e.code));
    } catch (e) {
      return Left(UpdateUserFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionModel>>> getHistorySubscription(
    UserModel user,
  ) async {
    try {
      final result = await updateUserDataSource.getHistorySubscription(user);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(UpdateUserFailure(message: e.code));
    } catch (e) {
      return Left(UpdateUserFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setSubscription(UserModel user) async {
    try {
      final result = await updateUserDataSource.setSubscription(user);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(UpdateUserFailure(message: e.code));
    } catch (e) {
      return Left(UpdateUserFailure(message: e.toString()));
    }
  }
}
