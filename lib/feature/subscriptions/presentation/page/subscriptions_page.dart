import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/widgets/container_pages.dart';
import 'package:bearbox/feature/subscriptions/presentation/cubit/subscriptions_cubit.dart';
import 'package:bearbox/feature/subscriptions/presentation/cubit/subscriptions_state.dart';
import 'package:bearbox/feature/subscriptions/presentation/widget/header_row_subscriptions_table.dart';
import 'package:bearbox/feature/subscriptions/presentation/widget/row_subscriptions_table.dart';
import 'package:bearbox/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class SubscriptionsPage
    extends BasePage<SubscriptionsState, SubscriptionsCubit> {
  const SubscriptionsPage({super.key});

  @override
  SubscriptionsCubit createBloc(BuildContext context) =>
      sl<SubscriptionsCubit>()..init(context);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.sizeHeight() * 0.05),
        ContainerPages(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SUSCRIPCIONES", style: MyFitUiKit.util.textStyle.titleXL),
              SizedBox(height: context.sizeHeight() * 0.04),
              TextField(
                controller: state.searchController,
                onChanged: (value) => bloc.filterSubscriptions(value),
                decoration: InputDecoration(
                  labelText: "Buscar por nombre o email",
                  hintText: "Escribe para buscar...",
                  prefixIcon: Icon(
                    Icons.search,
                    color: MyFitUiKit.util.color.primary,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: MyFitUiKit.util.color.textColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: MyFitUiKit.util.color.textColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: MyFitUiKit.util.color.primary,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: MyFitUiKit.util.color.backgroundButton,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: context.sizeHeight() * 0.03),

        // Tabs + PageView
        DefaultTabController(
          length: 2,
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cabecera dinámica que cambia con la pestaña seleccionada
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.sizeWidth() * 0.1,
                  ),
                  child: Builder(
                    builder: (context) {
                      final TabController controller = DefaultTabController.of(
                        context,
                      );
                      return AnimatedBuilder(
                        animation: controller.animation!,
                        builder: (context, _) {
                          final bool isMonthTab = controller.index == 0;
                          final String title = isMonthTab
                              ? "Total Suscripciones"
                              : "Total Activas";
                          final String value = isMonthTab
                              ? state.totalSubscriptions.toString()
                              : state.totalActiveSubscriptions.toString();

                          return Row(
                            children: [
                              Expanded(
                                child: _buildStatCard(
                                  title,
                                  value,
                                  Icons.people,
                                  Colors.blue,
                                ),
                              ),
                              SizedBox(width: context.sizeWidth() * 0.02),
                              Expanded(
                                child: _buildStatCard(
                                  "Capital Total del mes actual",
                                  "\$${state.totalRevenue.toStringAsFixed(2)}",
                                  Icons.attach_money,
                                  Colors.green,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: context.sizeHeight() * 0.02),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.sizeWidth() * 0.1,
                  ),
                  child: TabBar(
                    indicatorColor: MyFitUiKit.util.color.primary,
                    labelColor: MyFitUiKit.util.color.primary,
                    unselectedLabelColor: MyFitUiKit.util.color.textColor,
                    tabs: const [
                      Tab(text: 'Este mes'),
                      Tab(text: 'Activas'),
                    ],
                    onTap: (index) => bloc.setSelectedTab(index),
                  ),
                ),
                SizedBox(height: context.sizeHeight() * 0.01),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Página 1: Suscripciones del mes
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerPages(
                            body: HeaderRowSubscriptionsTable(),
                          ),
                          Expanded(
                            child: ContainerPages(
                              body: ListView.builder(
                                itemCount:
                                    state
                                        .filteredSubscriptionTableModels
                                        .isNotEmpty
                                    ? state
                                          .filteredSubscriptionTableModels
                                          .length
                                    : state.subscriptionTableModels.length,
                                itemBuilder: (_, index) {
                                  final subscription =
                                      state
                                          .filteredSubscriptionTableModels
                                          .isNotEmpty
                                      ? state
                                            .filteredSubscriptionTableModels[index]
                                      : state.subscriptionTableModels[index];

                                  return RowSubscriptionsTable(
                                    subscription: subscription,
                                    isLoading: state.isLoading,
                                    onTapUpdate: () =>
                                        bloc.goToUpdateSubscription(
                                          context,
                                          subscription,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Página 2: Suscripciones activas
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ContainerPages(
                            body: HeaderRowSubscriptionsTable(),
                          ),
                          Expanded(
                            child: ContainerPages(
                              body: ListView.builder(
                                itemCount:
                                    state
                                        .filteredActiveSubscriptionTableModels
                                        .isNotEmpty
                                    ? state
                                          .filteredActiveSubscriptionTableModels
                                          .length
                                    : state
                                          .activeSubscriptionTableModels
                                          .length,
                                itemBuilder: (_, index) {
                                  final subscription =
                                      state
                                          .filteredActiveSubscriptionTableModels
                                          .isNotEmpty
                                      ? state
                                            .filteredActiveSubscriptionTableModels[index]
                                      : state
                                            .activeSubscriptionTableModels[index];

                                  return RowSubscriptionsTable(
                                    subscription: subscription,
                                    isLoading: state.isLoading,
                                    onTapUpdate: () =>
                                        bloc.goToUpdateSubscription(
                                          context,
                                          subscription,
                                        ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: Text(
              value,
              key: ValueKey<String>(value),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
