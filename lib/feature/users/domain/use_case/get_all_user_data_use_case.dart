import 'package:dartz/dartz.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/feature/users/domain/repositories/user_repositories.dart';

class GetAllUserDataUseCase extends BaseUseCase<Stream<List<UserModel>>, NoParams> {
  GetAllUserDataUseCase({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Either<Failure, Stream<List<UserModel>>>> call(params) =>
      userRepository.getAllUserData();
}
