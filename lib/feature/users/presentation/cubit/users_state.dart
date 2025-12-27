part of 'users_cubit.dart';

class UsersState {
  final bool isLoading;
  final UserModel myUser;
  final List<UserModel> userModels;
  final List<UserTableModel> userTableModels;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController searchController;
  final bool showExpiredSubscriptionsOnly;

  const UsersState({
    required this.myUser,
    required this.isLoading,
    required this.userModels,
    required this.emailController,
    required this.userTableModels,
    required this.passwordController,
    required this.searchController,
    required this.showExpiredSubscriptionsOnly,
  });

  factory UsersState.init() => UsersState(
    userModels: [],
    isLoading: false,
    userTableModels: [],
    myUser: UserModel.init(),
    emailController: TextEditingController(),
    passwordController: TextEditingController(),
    searchController: TextEditingController(),
    showExpiredSubscriptionsOnly: false,
  );

  UsersState copyWith({
    bool? isLoading,
    UserModel? myUser,
    List<UserModel>? userModels,
    List<UserTableModel>? userTableModels,
    bool? showExpiredSubscriptionsOnly,
  }) => UsersState(
    myUser: myUser ?? this.myUser,
    emailController: emailController,
    isLoading: isLoading ?? this.isLoading,
    passwordController: passwordController,
    searchController: searchController,
    showExpiredSubscriptionsOnly:
        showExpiredSubscriptionsOnly ?? this.showExpiredSubscriptionsOnly,
    userModels: userModels ?? this.userModels,
    userTableModels: userTableModels ?? this.userTableModels,
  );
}
