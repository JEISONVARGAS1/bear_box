import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/feature/home/domain/repositories/home_repositories.dart';

class GetUserDataByEmailUseCase extends BaseUseCase<UserModel, String> {
  GetUserDataByEmailUseCase({required this.homeRepository});

  final HomeRepository homeRepository;

  @override
  Future<Either<Failure, UserModel>> call(String params) =>
      homeRepository.getUserDataByEmail(params);
}
