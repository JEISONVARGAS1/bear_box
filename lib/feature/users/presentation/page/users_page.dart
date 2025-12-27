import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/widgets/container_pages.dart';
import 'package:bearbox/feature/users/presentation/cubit/users_cubit.dart';
import 'package:bearbox/feature/users/presentation/widget/header_row_users_table.dart';
import 'package:bearbox/feature/users/presentation/widget/row_users_table.dart';
import 'package:bearbox/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class UsersPage extends BasePage<UsersState, UsersCubit> {
  const UsersPage({super.key});

  int _getExpiredSubscriptionsCount(List<UserModel> users) {
    return users.where((user) {
      if (user.dateSubscription == null) return false;

      final expirationDate = user.dateSubscription!.copyWith(
        month: user.dateSubscription!.month + 1,
      );

      return expirationDate.isBefore(DateTime.now());
    }).length;
  }

  @override
  UsersCubit createBloc(BuildContext context) =>
      sl<UsersCubit>()..init(context);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.sizeHeight() * 0.05),
        ContainerPages(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("USERS", style: MyFitUiKit.util.textStyle.titleXL),
                  Row(
                    children: [
                      // Botón de filtro de suscripciones vencidas
                      Container(
                        margin: EdgeInsets.only(
                          right: context.sizeWidth() * 0.02,
                        ),
                        child: MaterialButton(
                          color: state.showExpiredSubscriptionsOnly
                              ? MyFitUiKit.util.color.delete
                              : MyFitUiKit.util.color.primary,
                          onPressed: () =>
                              bloc.toggleExpiredSubscriptionsFilter(),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "Vencidas",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Botón de agregar usuario
                      MaterialButton(
                        color: MyFitUiKit.util.color.primary,
                        onPressed: () => bloc.goToCreateUser(context),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.sizeHeight() * 0.02),
              // Indicador de usuarios con suscripción vencida
              if (!state.showExpiredSubscriptionsOnly) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: MyFitUiKit.util.color.delete.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: MyFitUiKit.util.color.delete.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning,
                        color: MyFitUiKit.util.color.delete,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${_getExpiredSubscriptionsCount(state.userModels)} usuarios con suscripción vencida",
                        style: TextStyle(
                          color: MyFitUiKit.util.color.delete,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.sizeHeight() * 0.02),
              ],
              TextField(
                controller: state.searchController,
                onChanged: (value) => bloc.filterUsers(value),
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
        SizedBox(height: context.sizeHeight() * 0.05),
        const ContainerPages(body: HeaderRowUsersTable()),
        Flexible(
          child: ContainerPages(
            body: ListView.builder(
              itemCount: state.userTableModels.length,
              itemBuilder: (_, index) => RowUsersTable(
                onTapItem: () =>
                    bloc.goToMedicalPage(context, state.userTableModels[index]),
                user: state.userTableModels[index],
                isLoading: state.isLoading,
                onTapUpdate: () =>
                    bloc.goToUpdateUser(context, state.userTableModels[index]),
                onTapMedical: () => bloc.showMedicalHistory(
                  context,
                  state.userTableModels[index],
                ),
                onTapDelete: () =>
                    bloc.deleteUser(context, state.userTableModels[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
