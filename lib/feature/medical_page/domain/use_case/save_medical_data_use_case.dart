import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/feature/medical_page/domain/repositories/medical_page_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class SaveMedicalDataParams {
  final UserModel user;
  final UserMedicalData medicalData;

  SaveMedicalDataParams({required this.user, required this.medicalData});
}

class SaveMedicalDataUseCase extends BaseUseCase<bool, SaveMedicalDataParams> {
  SaveMedicalDataUseCase({required this.medicalPageRepository});

  final MedicalPageRepository medicalPageRepository;

  @override
  Future<Either<Failure, bool>> call(SaveMedicalDataParams params) =>
      medicalPageRepository.saveMedicalData(params.user, params.medicalData);
}
