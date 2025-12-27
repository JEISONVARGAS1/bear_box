import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/update_user/domain/use_case/get_history_subscription_use_case.dart';
import 'package:bearbox/feature/update_user/domain/use_case/set_subscription_use_case.dart';
import 'package:bearbox/feature/update_user/domain/use_case/update_existed_workout_use_case.dart';
import 'package:bearbox/feature/update_user/domain/use_case/update_workout_use_case.dart';
import 'package:bearbox/feature/update_user/presentation/widget/popup_new_subscription_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  final UpdateUserUseCase _updateUserUseCase;
  final SetSubscriptionUseCase _setSubscriptionUseCase;
  final UpdateExistedWorkoutUseCase _updateExistedWorkoutUseCase;
  final GetHistorySubscriptionUseCase _getHistorySubscriptionUseCase;

  UpdateUserCubit({
    required UpdateUserUseCase updateUserUseCase,
    required SetSubscriptionUseCase setSubscriptionUseCase,
    required UpdateExistedWorkoutUseCase updateExistedWorkoutUseCase,
    required GetHistorySubscriptionUseCase getHistorySubscriptionUseCase,
  }) : _updateUserUseCase = updateUserUseCase,
       _setSubscriptionUseCase = setSubscriptionUseCase,
       _updateExistedWorkoutUseCase = updateExistedWorkoutUseCase,
       _getHistorySubscriptionUseCase = getHistorySubscriptionUseCase,
       super(UpdateUserState.init());

  void init(BuildContext context, UserModel user) async {
    _setData(user);
    _getHistorySubscription(context);
  }

  void selectGender(String gender) => emit(state.copyWith(gender: gender));

  void _getHistorySubscription(BuildContext context) async {
    final result = await _getHistorySubscriptionUseCase(state.userModel);
    result.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (List<SubscriptionModel> subscriptions) {
        final subscriptionsActive = subscriptions.toList();
        subscriptionsActive.removeWhere(
          (subscription) => subscription.endDate.isBefore(DateTime.now()),
        );
        subscriptions.sort((a, b) => a.endDate.compareTo(b.endDate));
        subscriptionsActive.sort((a, b) => a.endDate.compareTo(b.endDate));
        emit(
          state.copyWith(
            subscriptions: subscriptions,
            subscriptionsActive: subscriptionsActive,
          ),
        );
      },
    );
  }

  void selectBirthday(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 36500)),
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
    );

    if (date == null) return;

    final dateFormat = DateFormat('dd-MMM-yyyy', 'es');
    state.birthdayController.text = dateFormat.format(date);

    emit(state.copyWith(birthday: date));
  }

  String? validateName(String? text) {
    final newText = text ?? "";

    if (newText.isEmpty) return "this field cannot be empty";
    if (newText.length < 4) return "min 4 characters";
    return null;
  }

  String? validateHeight(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    final height = double.tryParse(newText);
    if (height == null || height <= 0) return "Altura inválida";
    return null;
  }

  String? validateWeight(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    final weight = double.tryParse(newText);
    if (weight == null || weight <= 0) return "Peso inválido";
    return null;
  }

  String? validateDocumentId(String? text) {
    final newText = text ?? "";
    if (newText.isEmpty) return "Este campo no puede estar vacío";
    if (newText.length < 8) return "Documento de identidad inválido";
    return null;
  }

  void updateExercise(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    final user = _generateUser();
    final resultDb = await _updateUserUseCase(user);

    resultDb.fold(
      (Failure failure) {
        emit(state.copyWith(isLoading: false));
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (bool item) {
        context.pop();
      },
    );
  }

  void selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    final listSubscription = state.subscriptions;
    if (listSubscription.isNotEmpty) {
      final lastItem = listSubscription.last;
      initialDate = lastItem.endDate.isAfter(DateTime.now())
          ? lastItem.endDate
          : DateTime.now();
    }
    if (state.subscriptions.isNotEmpty) {
      initialDate = state.subscriptions.first.endDate;
    }

    final date = await showDatePicker(
      context: context,
      firstDate: initialDate,
      initialDate: initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date == null) return;

    final dateFormat = DateFormat('dd-MMM-yyyy', 'es');
    state.subscriptionDateController.text = dateFormat.format(date);

    emit(state.copyWith(dateSubscription: date));
  }

  void selectPriceSubscription(String price) {
    final priceDouble = double.parse(
      price.replaceAll("\$", "").replaceAll(".", ""),
    );
    state.priceSubscriptionController.text = priceDouble.toString();
    emit(state.copyWith(priceSubscription: priceDouble));
  }

  void _setData(UserModel user) {
    state.nameController.text = user.name;
    state.phoneController.text = user.phone;
    state.addressController.text = user.address;
    state.documentIdController.text = user.documentId;
    state.addressDescriptionController.text = user.addressDescription;
    state.priceSubscriptionController.text = user.priceSubscription.toString();
    state.birthdayController.text = DateFormat(
      'dd-MMM-yyyy',
      'es',
    ).format(user.birthday);

    emit(
      state.copyWith(
        userModel: user,
        gender: user.gender,
        dateSubscription: user.dateSubscription,
        priceSubscription: user.priceSubscription,
      ),
    );
  }

  UserModel _generateUser() {
    return state.userModel.copyWith(
      gender: state.gender,
      birthday: state.birthday,
      dateUpdate: DateTime.now(),
      name: state.nameController.text,
      phone: state.phoneController.text,
      address: state.addressController.text,
      dateSubscription: state.dateSubscription,
      priceSubscription: state.priceSubscription,
      documentId: state.documentIdController.text,
      addressDescription: state.addressDescriptionController.text,
    );
  }

  void openSubscriptionPopup(BuildContext context) => showDialog(
    context: context,
    builder: (BuildContext context) =>
        PopupNewSubscriptionPage(cubit: this, state: state),
  );

  void createNewSubscription(BuildContext context) async {
    if (!state.formSubscriptionKey.currentState!.validate()) return;

    emit(state.copyWith(isLoading: true));

    final user = _generateUser();
    final resultDb = await _setSubscriptionUseCase(user);

    resultDb.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
        emit(state.copyWith(isLoading: false));
      },
      (bool item) {
        context.pop();
        emit(state.copyWith(isLoading: false));
        _getHistorySubscription(context);
      },
    );
  }

  void updateSubscription(
    BuildContext context,
    SubscriptionModel updatedSubscription,
  ) async {
    emit(state.copyWith(isLoading: true));

    final res = await _updateExistedWorkoutUseCase(updatedSubscription);
    res.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
        emit(state.copyWith(isLoading: false));
      },
      (bool item) {
        context.pop();
        emit(state.copyWith(isLoading: false));
        _getHistorySubscription(context);
      },
    );
  }

  @override
  Future<void> close() {
    state.nameController.dispose();
    state.descriptionController.dispose();

    return super.close();
  }
}
