import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/subscriptions/data/model/subscription_table_model.dart';
import 'package:flutter/material.dart';

class SubscriptionsState {
  final bool isLoading;
  final double totalRevenue;
  final int totalSubscriptions;
  final int activeSubscriptions;
  final bool showExpiredSubscriptionsOnly;
  final TextEditingController searchController;
  final List<SubscriptionModel> subscriptionModels;
  final List<SubscriptionTableModel> subscriptionTableModels;
  final List<SubscriptionTableModel> filteredSubscriptionTableModels;

  final int totalActiveSubscriptions;
  final List<SubscriptionModel> subscriptionActiveModels;
  final List<SubscriptionTableModel> activeSubscriptionTableModels;
  final List<SubscriptionTableModel> filteredActiveSubscriptionTableModels;
  final int selectedTabIndex; // 0: mes actual, 1: activas
  final List<SubscriptionTableModel> listBase; // lista visible según pestaña

  SubscriptionsState({
    required this.isLoading,
    required this.totalRevenue,
    required this.searchController,
    required this.totalSubscriptions,
    required this.subscriptionModels,
    required this.activeSubscriptions,
    required this.subscriptionTableModels,
    required this.showExpiredSubscriptionsOnly,
    required this.filteredSubscriptionTableModels,

    required this.totalActiveSubscriptions,
    required this.subscriptionActiveModels,
    required this.activeSubscriptionTableModels,
    required this.filteredActiveSubscriptionTableModels,
    required this.selectedTabIndex,
    required this.listBase,
  });

  factory SubscriptionsState.init() {
    return SubscriptionsState(
      isLoading: false,
      totalRevenue: 0.0,
      totalSubscriptions: 0,
      subscriptionModels: [],
      activeSubscriptions: 0,
      subscriptionTableModels: [],
      showExpiredSubscriptionsOnly: false,
      filteredSubscriptionTableModels: [],
      searchController: TextEditingController(),

      totalActiveSubscriptions: 0,
      subscriptionActiveModels: [],
      activeSubscriptionTableModels: [],
      filteredActiveSubscriptionTableModels: [],
      selectedTabIndex: 0,
      listBase: const [],
    );
  }

  SubscriptionsState copyWith({
    bool? isLoading,
    double? totalRevenue,
    int? totalSubscriptions,
    int? activeSubscriptions,
    bool? showExpiredSubscriptionsOnly,
    TextEditingController? searchController,
    List<SubscriptionModel>? subscriptionModels,
    List<SubscriptionTableModel>? subscriptionTableModels,
    List<SubscriptionTableModel>? filteredSubscriptionTableModels,

    int? totalActiveSubscriptions,
    List<SubscriptionModel>? subscriptionActiveModels,
    List<SubscriptionTableModel>? activeSubscriptionTableModels,
    List<SubscriptionTableModel>? filteredActiveSubscriptionTableModels,
    int? selectedTabIndex,
    List<SubscriptionTableModel>? listBase,
  }) {
    return SubscriptionsState(
      isLoading: isLoading ?? this.isLoading,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      searchController: searchController ?? this.searchController,
      totalSubscriptions: totalSubscriptions ?? this.totalSubscriptions,
      subscriptionModels: subscriptionModels ?? this.subscriptionModels,
      activeSubscriptions: activeSubscriptions ?? this.activeSubscriptions,
      subscriptionTableModels:
          subscriptionTableModels ?? this.subscriptionTableModels,
      showExpiredSubscriptionsOnly:
          showExpiredSubscriptionsOnly ?? this.showExpiredSubscriptionsOnly,
      filteredSubscriptionTableModels:
          filteredSubscriptionTableModels ??
          this.filteredSubscriptionTableModels,

      totalActiveSubscriptions:
          totalActiveSubscriptions ?? this.totalActiveSubscriptions,
      subscriptionActiveModels:
          subscriptionActiveModels ?? this.subscriptionActiveModels,
      activeSubscriptionTableModels:
          activeSubscriptionTableModels ?? this.activeSubscriptionTableModels,
      filteredActiveSubscriptionTableModels:
          filteredActiveSubscriptionTableModels ??
          this.filteredActiveSubscriptionTableModels,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      listBase: listBase ?? this.listBase,
    );
  }
}
