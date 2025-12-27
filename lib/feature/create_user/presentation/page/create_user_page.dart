import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/extension/double_extension.dart';
import 'package:bearbox/feature/create_user/presentation/cubit/create_user_cubit.dart';
import 'package:bearbox/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/models/button_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class CreateUserPage extends BasePage<CreateUserState, CreateUserCubit> {
  const CreateUserPage({super.key});

  @override
  CreateUserCubit createBloc(BuildContext context) =>
      sl<CreateUserCubit>()..init(context);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Scaffold(
      body: SizedBox(
        width: context.sizeWidth(),
        height: context.sizeHeight(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.sizeWidth(0.25),
            vertical: context.sizeHeight(0.1),
          ),
          child: Form(
            key: state.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Crear Usuario",
                  style: MyFitUiKit.util.textStyle.titleXL.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Nombre",
                  validator: bloc.validateName,
                  controller: state.nameController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Email",
                  controller: state.emailController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Documento de identidad",
                  validator: bloc.validateDocumentId,
                  controller: state.documentIdController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Dirección",
                  controller: state.addressController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  maxLine: 5,
                  label: "Descripción de la dirección",
                  controller: state.addressDescriptionController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Número celular",
                  validator: bloc.validateName,
                  controller: state.phoneController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.dropdownWritableInput(
                  label: "Género",
                  hintText: "Selecciona el género",
                  items: ["MALE", "FEMALE"],
                  onSuggestionSelected: (suggestion) =>
                      bloc.selectGender(suggestion),
                  dropdownSearchFieldController: TextEditingController(
                    text: state.gender,
                  ),
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  readOnly: true,
                  label: "Fecha de nacimiento",
                  onTap: () => bloc.selectBirthday(context),
                  controller: state.birthdayController,
                ),

                context.sizeHeight(0.1).heightWidget(),
                Text(
                  "Suscripción de gimnasio",
                  style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.01).heightWidget(),
                Divider(thickness: 1, color: MyFitUiKit.util.color.white),
                context.sizeHeight(0.01).heightWidget(),
                MyFitUiKit.widget.form.input(
                  readOnly: true,
                  label: "Fecha de suscripción",
                  onTap: () => bloc.selectDate(context),
                  controller: state.subscriptionDateController,
                ),
                context.sizeHeight(0.01).heightWidget(),

                MyFitUiKit.widget.form.dropdownWritableInput(
                  label: "Precio de la suscripción",
                  hintText: "Selecciona un precio",
                  items: ["45.000\$", "60.000\$", "120.000\$"],
                  onSuggestionSelected: (suggestion) =>
                      bloc.selectPriceSubscription(suggestion),
                  dropdownSearchFieldController:
                      state.priceSubscriptionController,
                ),

                context.sizeHeight(0.1).heightWidget(),

                state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyFitUiKit.util.color.textColor,
                        ),
                      )
                    : MyFitUiKit.widget.button.formButton(
                        ButtonModel(
                          label: "Crear Usuario",
                          onTap: () => bloc.createUser(context),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
