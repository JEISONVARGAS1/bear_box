part of 'login_cubit.dart';

class LoginState {
  final UserModel user;
  final bool isLoading;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginState({
    required this.user,
    required this.isLoading,
    required this.emailController,
    required this.passwordController,
  });

  factory LoginState.init() => LoginState(
        isLoading: false,
        user: UserModel.init(),
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
      );

  LoginState copyWith({
    bool? isLoading,
    UserModel? user,
  }) =>
      LoginState(
        user: user ?? this.user,
        emailController: emailController,
        passwordController: passwordController,
        isLoading: isLoading ?? this.isLoading,
      );
}
