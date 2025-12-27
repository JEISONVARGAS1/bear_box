import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bearbox/feature/home/presentation/widget/custom_app_bar.dart';
import 'package:bearbox/feature/subscriptions/presentation/page/subscriptions_page.dart';
import 'package:bearbox/feature/users/presentation/page/users_page.dart';
import 'package:bearbox/injection_container.dart';
import 'package:flutter/material.dart';

class HomePage extends BasePage<HomeState, HomeCubit> {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  HomeCubit createBloc(BuildContext context) =>
      sl<HomeCubit>()..init(context, email);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Scaffold(
      appBar: CustomAppBar(
        menuOptions: state.menuList,
        onTapMenu: bloc.handledMenuTap,
        valueSelected: state.menuSelected,
        onTapLogout: () => bloc.logout(context),
      ),
      body: PageView(
        controller: state.controller,
        children: [const UsersPage(), const SubscriptionsPage()],
      ),
    );
  }
}
