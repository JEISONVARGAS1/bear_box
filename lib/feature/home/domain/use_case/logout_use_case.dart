import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/feature/home/domain/repositories/home_repositories.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase extends BaseUseCase<bool, NoParams> {
  LogoutUseCase({required this.homeRepository});

  final HomeRepository homeRepository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final result = await homeRepository.logout();
    return result.fold((l) => Left(l), (r) => Right(true));
  }
}
