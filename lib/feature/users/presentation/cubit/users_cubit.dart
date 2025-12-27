import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/user_medical_data.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/medical_page/domain/use_case/get_medical_history_use_case.dart';
import 'package:bearbox/feature/medical_page/presentation/widget/medical_history_dialog.dart';
import 'package:bearbox/feature/users/data/model/user_table_model.dart';
import 'package:bearbox/feature/users/domain/use_case/delete_user_use_case.dart';
import 'package:bearbox/feature/users/domain/use_case/get_all_user_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final GetAllUserDataUseCase _getAllUserDataUseCase;
  final GetMedicalHistoryUseCase _getMedicalHistoryUseCase;
  final DeleteUserUseCase _deleteUserUseCase;

  UsersCubit({
    required GetAllUserDataUseCase getAllUserDataUseCase,
    required GetMedicalHistoryUseCase getMedicalHistoryUseCase,
    required DeleteUserUseCase deleteUserUseCase,
  }) : _getAllUserDataUseCase = getAllUserDataUseCase,
       _getMedicalHistoryUseCase = getMedicalHistoryUseCase,
       _deleteUserUseCase = deleteUserUseCase,
       super(UsersState.init());

  init(BuildContext context) => _getAllUser(context);

  _getAllUser(BuildContext context) async {
    final resultDb = await _getAllUserDataUseCase(NoParams());
    resultDb.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (Stream<List<UserModel>> users) {
        users.listen((users) {
          final userTableModel = users
              .map((e) => UserTableModel.fromUserModel(e))
              .toList();
          emit(
            state.copyWith(userTableModels: userTableModel, userModels: users),
          );
        });
      },
    );
  }

  void filterUsers(String searchQuery) {
    _applyFilters(searchQuery, state.showExpiredSubscriptionsOnly);
  }

  void toggleExpiredSubscriptionsFilter() {
    final newFilterState = !state.showExpiredSubscriptionsOnly;
    _applyFilters(state.searchController.text, newFilterState);
    emit(state.copyWith(showExpiredSubscriptionsOnly: newFilterState));
  }

  void _applyFilters(String searchQuery, bool showExpiredOnly) {
    List<UserModel> filteredUsers = state.userModels;

    if (searchQuery.isNotEmpty) {
      filteredUsers = filteredUsers.where((user) {
        final name = user.name.toLowerCase();
        final email = user.email.toLowerCase();
        final documentId = user.documentId.toLowerCase();
        final query = searchQuery.toLowerCase();

        return name.contains(query) ||
            email.contains(query) ||
            (documentId.contains(query));
      }).toList();
    }

    if (showExpiredOnly) {
      filteredUsers = filteredUsers.where((user) {
        if (user.dateSubscription == null) return false;

        final expirationDate = user.dateSubscription!.copyWith(
          month: user.dateSubscription!.month + 1,
        );

        // Verificar si la suscripción ha vencido
        return expirationDate.isBefore(DateTime.now());
      }).toList();
    }

    final userTableModel = filteredUsers
        .map((e) => UserTableModel.fromUserModel(e))
        .toList();

    emit(state.copyWith(userTableModels: userTableModel));
  }

  goToUpdateUser(BuildContext context, UserTableModel userTable) {
    final userModel = state.userModels.firstWhere((e) => e.id == userTable.id);
    context.push("/home/update-user", extra: userModel);
  }

  goToCreateUser(BuildContext context) {
    context.push("/home/create-user");
  }

  goToMedicalPage(BuildContext context, UserTableModel userTable) {
    final userModel = state.userModels.firstWhere((e) => e.id == userTable.id);
    context.push("/home/medical-page", extra: userModel);
  }

  void showMedicalHistory(
    BuildContext context,
    UserTableModel userTable,
  ) async {
    final userModel = state.userModels.firstWhere((e) => e.id == userTable.id);

    emit(state.copyWith(isLoading: true));

    final result = await _getMedicalHistoryUseCase(
      GetMedicalHistoryParams(user: userModel),
    );

    result.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (List<UserMedicalData> medicalHistory) {
        emit(state.copyWith(isLoading: false));
        _showMedicalHistoryDialog(context, userModel, medicalHistory);
      },
    );
  }

  void _showMedicalHistoryDialog(
    BuildContext context,
    UserModel user,
    List<UserMedicalData> medicalHistory,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          MedicalHistoryDialog(user: user, medicalHistory: medicalHistory),
    );
  }

  void deleteUser(BuildContext context, UserTableModel userTable) async {
    final userModel = state.userModels.firstWhere((e) => e.id == userTable.id);

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Usuario'),
          content: Text(
            '¿Estás seguro de que quieres eliminar a ${userModel.name}?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      emit(state.copyWith(isLoading: true));

      final result = await _deleteUserUseCase(
        DeleteUserParams(userId: userModel.id!.id),
      );

      result.fold(
        (Failure failure) {
          emit(state.copyWith(isLoading: false));
          appSnackBarMessage(
            context,
            isSuccess: false,
            message: failure.message,
          );
        },
        (_) {
          emit(state.copyWith(isLoading: false));
          appSnackBarMessage(
            context,
            isSuccess: true,
            message: 'Usuario eliminado exitosamente',
          );
        },
      );
    }
  }
}
