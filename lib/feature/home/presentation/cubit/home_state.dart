part of 'home_cubit.dart';

class HomeState {
  final int index;
  final UserModel user;
  final bool isLoading;
  final MenuOptions menuSelected;
  final PageController controller;
  final List<MenuOptions> menuList;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const HomeState({
    required this.user,
    required this.index,
    required this.menuList,
    required this.isLoading,
    required this.controller,
    required this.menuSelected,
    required this.emailController,
    required this.passwordController,
  });

  factory HomeState.init() => HomeState(
    index: 0,
    isLoading: false,
    user: UserModel.init(),
    controller: PageController(),
    menuSelected: MenuOptions.USERS,
    menuList: [MenuOptions.USERS, MenuOptions.SUBSCRIPTIONS],
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
  );

  HomeState copyWith({
    int? index,
    bool? isLoading,
    UserModel? user,
    MenuOptions? menuSelected,
  }) => HomeState(
    menuList: menuList,
    controller: controller,
    user: user ?? this.user,
    index: index ?? this.index,
    emailController: emailController,
    isLoading: isLoading ?? this.isLoading,
    passwordController: passwordController,
    menuSelected: menuSelected ?? this.menuSelected,
  );
}
