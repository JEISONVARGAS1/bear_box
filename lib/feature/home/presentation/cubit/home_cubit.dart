import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/home/data/model/menu_enum.dart';
import 'package:bearbox/feature/home/domain/use_case/get_user_data_use_case.dart';
import 'package:bearbox/feature/home/domain/use_case/logout_use_case.dart';
import 'package:bearbox/feature/medical_page/domain/use_case/get_medical_history_use_case.dart';
import 'package:bearbox/feature/medical_page/presentation/widget/medical_history_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final LogoutUseCase _logoutUseCase;
  final GetUserDataByEmailUseCase _getUserDataByEmailUseCase;
  final GetMedicalHistoryUseCase _getMedicalHistoryUseCase;

  HomeCubit({
    required LogoutUseCase logoutUseCase,
    required GetUserDataByEmailUseCase getUserDataByEmailUseCase,
    required GetMedicalHistoryUseCase getMedicalHistoryUseCase,
  }) : _logoutUseCase = logoutUseCase,
       _getUserDataByEmailUseCase = getUserDataByEmailUseCase,
       _getMedicalHistoryUseCase = getMedicalHistoryUseCase,
       super(HomeState.init());

  init(BuildContext context, String email) {
    emit(HomeState.init());
    _getUserDataByEmail(context, email);
  }

  _getUserDataByEmail(BuildContext context, String email) async {
    final resultDb = await _getUserDataByEmailUseCase(email);
    resultDb.fold(
      (Failure failure) {
        final message = failure.message;
        appSnackBarMessage(context, isSuccess: false, message: message);
      },
      (UserModel user) {
        emit(state.copyWith(user: user));
      },
    );
  }

  handledMenuTap(MenuOptions item) {
    final newIndex = state.menuList.indexWhere((element) => element == item);
    emit(state.copyWith(menuSelected: item, index: newIndex));
    state.controller.jumpToPage(state.index);
  }

  void showMedicalHistory(BuildContext context) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getMedicalHistoryUseCase(
      GetMedicalHistoryParams(user: state.user),
    );

    result.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (List<UserMedicalData> medicalHistory) {
        emit(state.copyWith(isLoading: false));
        _showMedicalHistoryDialog(context, medicalHistory);
      },
    );
  }

  void _showMedicalHistoryDialog(
    BuildContext context,
    List<UserMedicalData> medicalHistory,
  ) {
    showDialog(
      context: context,
      builder: (context) => MedicalHistoryDialog(
        user: state.user,
        medicalHistory: medicalHistory,
      ),
    );
  }

  void logout(BuildContext context) async {
    final result = await _logoutUseCase(NoParams());
    result.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (bool success) {
        context.go('/');
      },
    );
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
