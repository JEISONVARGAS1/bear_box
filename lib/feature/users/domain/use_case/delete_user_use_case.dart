import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/feature/users/domain/repositories/user_repositories.dart';
import 'package:dartz/dartz.dart';

class DeleteUserUseCase extends BaseUseCase<void, DeleteUserParams> {
  DeleteUserUseCase({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Either<Failure, void>> call(DeleteUserParams params) =>
      userRepository.deleteUser(params.userId);
}

class DeleteUserParams {
  final String userId;

  DeleteUserParams({required this.userId});
}
