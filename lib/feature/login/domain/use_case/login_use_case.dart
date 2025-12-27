import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/feature/login/domain/repositories/login_repositories.dart';

class LoginUseCase extends BaseUseCase<User, LoginUseCaseParams> {
  LoginUseCase({required this.loginRepository});

  final LoginRepository loginRepository;

  @override
  Future<Either<Failure, User>> call(LoginUseCaseParams params) =>
      loginRepository.login(params.email, params.password);
}

class LoginUseCaseParams{

  final String email;
  final String password;

  LoginUseCaseParams({required this.password, required this.email});
}
