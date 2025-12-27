import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/feature/medical_page/domain/repositories/medical_page_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class GetMedicalHistoryParams {
  final UserModel user;

  GetMedicalHistoryParams({required this.user});
}

class GetMedicalHistoryUseCase
    extends BaseUseCase<List<UserMedicalData>, GetMedicalHistoryParams> {
  GetMedicalHistoryUseCase({required this.medicalPageRepository});

  final MedicalPageRepository medicalPageRepository;

  @override
  Future<Either<Failure, List<UserMedicalData>>> call(
    GetMedicalHistoryParams params,
  ) => medicalPageRepository.getMedicalHistory(params.user);
}
