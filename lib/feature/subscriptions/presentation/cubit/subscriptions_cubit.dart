import 'package:bearbox/core/base/base_usecase.dart';
import 'package:bearbox/core/errors/failure.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/core/util/app_snack_bar_message.dart';
import 'package:bearbox/feature/login/domain/use_case/get_user_data_use_case.dart';
import 'package:bearbox/feature/subscriptions/data/model/subscription_table_model.dart';
import 'package:bearbox/feature/subscriptions/domain/use_case/get_all_active_subscriptions_use_case.dart';
import 'package:bearbox/feature/subscriptions/domain/use_case/get_all_subscriptions_use_case.dart';
import 'package:bearbox/feature/subscriptions/presentation/cubit/subscriptions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

class SubscriptionsCubit extends Cubit<SubscriptionsState> {
  final GetUserDataUseCase _getUserDataUseCase;
  final GetAllSubscriptionsUseCase _getAllSubscriptionsUseCase;
  final GetAllActiveSubscriptionsUseCase _getAllActiveSubscriptionsUseCase;

  SubscriptionsCubit({
    required GetUserDataUseCase getUserDataUseCase,
    required GetAllSubscriptionsUseCase getAllSubscriptionsUseCase,
    required GetAllActiveSubscriptionsUseCase getAllActiveSubscriptionsUseCase,
  }) : _getUserDataUseCase = getUserDataUseCase,
       _getAllSubscriptionsUseCase = getAllSubscriptionsUseCase,
       _getAllActiveSubscriptionsUseCase = getAllActiveSubscriptionsUseCase,
       super(SubscriptionsState.init());

  init(BuildContext context) {
    _getAllSubscriptions(context);
    _getAllActiveSubscriptions(context);
  }

  void setSelectedTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
    _applyFilters(
      state.searchController.text,
      state.showExpiredSubscriptionsOnly,
    );
  }

  _getAllSubscriptions(BuildContext context) async {
    final resultDb = await _getAllSubscriptionsUseCase(NoParams());
    resultDb.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (Stream<List<SubscriptionModel>> subscriptions) {
        subscriptions.listen((subscriptionsList) {
          final subscriptionTableModels = subscriptionsList
              .map((subscription) => _createTableModel(subscription))
              .where((tableModel) => tableModel != null)
              .cast<SubscriptionTableModel>()
              .toList();

          final totalSubscriptions = subscriptionTableModels.length;
          final totalRevenue = subscriptionTableModels.fold<double>(
            0,
            (sum, sub) => sum + sub.price,
          );
          final activeSubscriptions = subscriptionTableModels
              .where((sub) => sub.endDate.isAfter(DateTime.now()))
              .length;

          emit(
            state.copyWith(
              totalRevenue: totalRevenue,
              subscriptionModels: subscriptionsList,
              totalSubscriptions: totalSubscriptions,
              activeSubscriptions: activeSubscriptions,
              subscriptionTableModels: subscriptionTableModels,
            ),
          );
        });
      },
    );
  }

  _getAllActiveSubscriptions(BuildContext context) async {
    final resultDb = await _getAllActiveSubscriptionsUseCase(NoParams());
    resultDb.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (Stream<List<SubscriptionModel>> subscriptions) {
        subscriptions.listen((subscriptionsList) {
          final subscriptionTableModels = subscriptionsList
              .map((subscription) => _createTableModel(subscription))
              .where((tableModel) => tableModel != null)
              .cast<SubscriptionTableModel>()
              .toList();

          emit(
            state.copyWith(
              subscriptionActiveModels: subscriptionsList,
              totalActiveSubscriptions: subscriptionsList.length,
              activeSubscriptionTableModels: subscriptionTableModels,
            ),
          );
        });
      },
    );
  }

  SubscriptionTableModel? _createTableModel(SubscriptionModel subscription) {
    return SubscriptionTableModel.fromSubscriptionModel(subscription, '');
  }

  void filterSubscriptions(String searchQuery) {
    _applyFilters(searchQuery, state.showExpiredSubscriptionsOnly);
  }

  void toggleExpiredSubscriptionsFilter() {
    final newFilterState = !state.showExpiredSubscriptionsOnly;
    _applyFilters(state.searchController.text, newFilterState);
    emit(state.copyWith(showExpiredSubscriptionsOnly: newFilterState));
  }

  void _applyFilters(String searchQuery, bool showExpiredOnly) {
    // Base de datos según pestaña
    final List<SubscriptionTableModel> baseMonth =
        state.subscriptionTableModels;
    final List<SubscriptionTableModel> baseActive =
        state.activeSubscriptionTableModels;

    // Filtrar por búsqueda
    List<SubscriptionTableModel> filteredMonth = baseMonth;
    List<SubscriptionTableModel> filteredActive = baseActive;

    if (searchQuery.isNotEmpty) {
      bool matches(SubscriptionTableModel subscription) {
        final userName = subscription.userName.toLowerCase();
        final userEmail = subscription.userEmail.toLowerCase();
        final query = searchQuery.toLowerCase();
        return userName.contains(query) || userEmail.contains(query);
      }

      filteredMonth = filteredMonth.where(matches).toList();
      filteredActive = filteredActive.where(matches).toList();
    }

    if (showExpiredOnly) {
      filteredMonth = filteredMonth
          .where(
            (subscription) => subscription.endDate.isBefore(DateTime.now()),
          )
          .toList();
      filteredActive = filteredActive
          .where(
            (subscription) => subscription.endDate.isBefore(DateTime.now()),
          )
          .toList();
    }

    emit(
      state.copyWith(
        filteredSubscriptionTableModels: filteredMonth,
        filteredActiveSubscriptionTableModels: filteredActive,
        listBase: state.selectedTabIndex == 0 ? filteredMonth : filteredActive,
      ),
    );
  }

  Future<void> goToUpdateSubscription(
    BuildContext context,
    SubscriptionTableModel subscription,
  ) async {
    final res = await _getUserDataUseCase(subscription.id);

    res.fold(
      (Failure failure) {
        appSnackBarMessage(context, isSuccess: false, message: failure.message);
      },
      (UserModel user) {
        context.push("/home/update-user", extra: user);
      },
    );
  }
}
