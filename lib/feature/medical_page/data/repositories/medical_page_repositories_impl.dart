import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/feature/medical_page/data/data_source/medical_page_data_source.dart';
import 'package:bearbox/feature/medical_page/domain/repositories/medical_page_repositories.dart';
import 'package:dartz/dartz.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class MedicalPageRepositoryImpl implements MedicalPageRepository {
  final MedicalPageDataSource _medicalPageDataSource;

  MedicalPageRepositoryImpl({
    required MedicalPageDataSource medicalPageDataSource,
  }) : _medicalPageDataSource = medicalPageDataSource;

  @override
  Future<Either<Failure, bool>> saveMedicalData(
    UserModel user,
    UserMedicalData medicalData,
  ) async {
    try {
      final result = await _medicalPageDataSource.saveMedicalData(
        user,
        medicalData,
      );
      return Right(result);
    } catch (e) {
      return Left(MedicalDataFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserMedicalData>>> getMedicalHistory(
    UserModel user,
  ) async {
    try {
      final result = await _medicalPageDataSource.getMedicalHistory(user);
      return Right(result);
    } catch (e) {
      return Left(MedicalDataFailure(message: e.toString()));
    }
  }
}
