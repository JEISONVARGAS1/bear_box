// ignore_for_file: depend_on_referenced_packages
import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/feature/login/presentation/cubit/login_cubit.dart';
import 'package:bearbox/injection_container.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/models/button_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class LoginPage extends BasePage<LoginState, LoginCubit> {
  const LoginPage({super.key});

  @override
  LoginCubit createBloc(BuildContext context) =>
      sl<LoginCubit>()..init(context);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Scaffold(
      body: SizedBox(
        width: context.sizeWidth(),
        height: context.sizeHeight(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 50,
              child: Image(
                height: 250,
                image: AssetImage('assets/images/bearbox.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.sizeWidth() * 0.25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*const Image(
                    height: 200,
                    image: AssetImage(
                      'assets/images/login3.png',
                    ),
                  ),*/
                  SizedBox(height: context.sizeHeight() * 0.07),
                  MyFitUiKit.widget.form.input(
                    label: "email".tr(),
                    controller: state.emailController,
                  ),
                  SizedBox(height: context.sizeHeight() * 0.03),
                  MyFitUiKit.widget.form.input(
                    label: "password".tr(),
                    controller: state.passwordController,
                  ),
                  SizedBox(height: context.sizeHeight() * 0.07),
                  state.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : MyFitUiKit.widget.button.formButton(
                          ButtonModel(
                            label: "logIn".tr(),
                            onTap: () => bloc.login(context),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
