// ignore_for_file: depend_on_referenced_packages
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/login/domain/use_case/get_user_data_use_case.dart';
import 'package:bearbox/feature/login/domain/use_case/login_use_case.dart';
import 'package:bearbox/feature/login/domain/use_case/save_hive_user_data_use_case.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final SaveHiveUserUseCase _saveHiveUserUseCase;

  LoginCubit({
    required LoginUseCase loginUseCase,
    required GetUserDataUseCase getUserDataUseCase,
    required SaveHiveUserUseCase saveHiveUserUseCase,
  }) : _loginUseCase = loginUseCase,
       _getUserDataUseCase = getUserDataUseCase,
       _saveHiveUserUseCase = saveHiveUserUseCase,
       super(LoginState.init());

  init(BuildContext context) {
    emit(LoginState.init());
  }

  _goToHome(BuildContext context) => context.go("/home");

  @override
  Future<void> close() {
    state.emailController.dispose();
    state.passwordController.dispose();
    return super.close();
  }

  login(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    final resultDb = await _loginUseCase(
      LoginUseCaseParams(
        password: state.passwordController.text,
        email: state.emailController.text,
      ),
    );
    resultDb.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        final message = failure.message;
        appSnackBarMessage(context, isSuccess: false, message: message);
      },
      (User user) {
        getUserData(context, user.uid);
      },
    );
  }

  getUserData(BuildContext context, String id) async {
    final resultDb = await _getUserDataUseCase(id);
    resultDb.fold(
      (Failure failure) {
        final message = failure.message;
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: message);
      },
      (UserModel user) {
        _saveUser(context, user);
      },
    );
  }

  _saveUser(BuildContext context, UserModel userModel) async {
    final resultDb = await _saveHiveUserUseCase(userModel);
    resultDb.fold(
      (Failure failure) {
        final message = failure.message;
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: message);
      },
      (void r) {
        _goToHome(context);
      },
    );
  }
}
