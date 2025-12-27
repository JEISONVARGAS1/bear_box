import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/extension/double_extension.dart';
import 'package:bearbox/feature/update_user/presentation/cubit/update_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/models/button_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class PopupNewSubscriptionPage extends StatelessWidget {
  final UpdateUserCubit cubit;
  final UpdateUserState state;

  const PopupNewSubscriptionPage({
    super.key,
    required this.cubit,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: state.formSubscriptionKey,
      child: Dialog(
        backgroundColor: MyFitUiKit.util.color.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Crear Nueva Suscripción",
                style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              context.sizeHeight(0.03).heightWidget(),
              MyFitUiKit.widget.form.input(
                readOnly: true,
                label: "Nueva Fecha de suscripción",
                onTap: () => cubit.selectDate(context),
                controller: state.subscriptionDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
              context.sizeHeight(0.02).heightWidget(),
              MyFitUiKit.widget.form.dropdownWritableInput(
                label: "Precio de la suscripción",
                hintText: "Selecciona un precio",
                items: ["45.000\$", "60.000\$", "120.000\$"],
                onSuggestionSelected: (suggestion) =>
                    cubit.selectPriceSubscription(suggestion),
                dropdownSearchFieldController:
                    state.priceSubscriptionController,
              ),
              context.sizeHeight(0.03).heightWidget(),
              MyFitUiKit.widget.button.formButton(
                ButtonModel(
                  label: "Crear Suscripción",
                  onTap: () => cubit.createNewSubscription(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
