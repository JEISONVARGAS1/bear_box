import 'package:dartz/dartz.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/base/base_usecase.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/feature/create_user/domain/repositories/create_user_repositories.dart';

class GenerateMedicalDataParams {
  final UserModel user;
  final UserMedicalData medicalData;

  GenerateMedicalDataParams({required this.user, required this.medicalData});
}

class GenerateMedicalDataUseCase extends BaseUseCase<bool, GenerateMedicalDataParams> {
  GenerateMedicalDataUseCase({required this.createUserRepository});

  final CreateUserRepository createUserRepository;

  @override
  Future<Either<Failure, bool>> call(GenerateMedicalDataParams params) =>
      createUserRepository.generateMedicalData(params.user, params.medicalData);
} 