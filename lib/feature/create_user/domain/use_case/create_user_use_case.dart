import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/feature/create_user/domain/repositories/create_user_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class CreateUserParams {
  final UserModel user;
  final UserMedicalData medicalData;

  CreateUserParams({required this.user, required this.medicalData});
}

class CreateUserUseCase extends BaseUseCase<bool, CreateUserParams> {
  CreateUserUseCase({required this.createUserRepository});

  final CreateUserRepository createUserRepository;

  @override
  Future<Either<Failure, bool>> call(CreateUserParams params) =>
      createUserRepository.createUser(params.user, params.medicalData);
}
