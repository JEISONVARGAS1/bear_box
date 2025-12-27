import 'package:bearbox/core/app/shared_preferences_manager.dart';
import 'package:bearbox/feature/create_user/presentation/page/create_user_page.dart';
import 'package:bearbox/feature/home/presentation/page/home_page.dart';
import 'package:bearbox/feature/login/presentation/page/login_page.dart';
import 'package:bearbox/feature/medical_page/presentation/page/medical_page.dart';
import 'package:bearbox/feature/update_user/presentation/page/update_user_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        try {
          final data = SharedPreferenceManager().getEmailAccount();
          if (data.isEmpty) return const LoginPage();
          return HomePage(email: data);
        } catch (e) {
          // Si hay error, mostrar login page
          return const LoginPage();
        }
      },
    ),
    GoRoute(
      path: "/home",
      name: "home",
      routes: <RouteBase>[
        GoRoute(
          path: "update-user",
          builder: (BuildContext context, GoRouterState state) =>
              UpdateUserPage(user: _getParam<UserModel>(state) as UserModel),
        ),
        GoRoute(
          path: "create-user",
          builder: (BuildContext context, GoRouterState state) =>
              const CreateUserPage(),
        ),
        GoRoute(
          path: "medical-page",
          builder: (BuildContext context, GoRouterState state) =>
              MedicalPage(user: _getParam<UserModel>(state) as UserModel),
        ),
      ],
      builder: (BuildContext context, GoRouterState state) {
        try {
          final data = SharedPreferenceManager().getEmailAccount();
          if (data.isEmpty) return const LoginPage();
          return HomePage(email: data);
        } catch (e) {
          // Si hay error, mostrar login page
          return const LoginPage();
        }
      },
    ),
  ],
);

T? _getParam<T>(GoRouterState state) =>
    state.extra != null ? _generateParams<T>(state.extra) : null;

T _generateParams<T>(final map) => map;
