import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/extension/double_extension.dart';
import 'package:bearbox/core/model/subscription_model.dart';
import 'package:bearbox/feature/update_user/presentation/cubit/update_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_fit_ui_kit/models/button_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class PopupEditSubscriptionPage extends StatefulWidget {
  final UpdateUserCubit cubit;
  final SubscriptionModel subscription;

  const PopupEditSubscriptionPage({
    super.key,
    required this.cubit,
    required this.subscription,
  });

  @override
  State<PopupEditSubscriptionPage> createState() =>
      _PopupEditSubscriptionPageState();
}

class _PopupEditSubscriptionPageState extends State<PopupEditSubscriptionPage> {
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController priceController;
  late TextEditingController notesController;
  late DateTime startDate;
  late DateTime endDate;
  late double price;
  late String? notes;
  late bool isActive;

  @override
  void initState() {
    super.initState();
    startDate = widget.subscription.startDate;
    endDate = widget.subscription.endDate;
    price = widget.subscription.price;
    notes = widget.subscription.notes;
    isActive = widget.subscription.isActive;

    startDateController = TextEditingController(
      text: DateFormat('dd-MMM-yyyy', 'es').format(startDate),
    );
    endDateController = TextEditingController(
      text: DateFormat('dd-MMM-yyyy', 'es').format(endDate),
    );
    priceController = TextEditingController(text: price.toString());
    notesController = TextEditingController(text: notes ?? '');
  }

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    priceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Dialog(
        backgroundColor: MyFitUiKit.util.color.cardDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Editar Suscripción",
                style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              context.sizeHeight(0.03).heightWidget(),

              // Fecha de inicio
              MyFitUiKit.widget.form.input(
                readOnly: true,
                label: "Fecha de inicio",
                onTap: () => _selectStartDate(context),
                controller: startDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
              context.sizeHeight(0.02).heightWidget(),

              // Fecha de fin
              MyFitUiKit.widget.form.input(
                readOnly: true,
                label: "Fecha de fin",
                onTap: () => _selectEndDate(context),
                controller: endDateController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Este campo no puede estar vacío";
                  }
                  return null;
                },
              ),
              context.sizeHeight(0.02).heightWidget(),

              // Precio
              MyFitUiKit.widget.form.dropdownWritableInput(
                label: "Precio de la suscripción",
                hintText: "Selecciona un precio",
                items: ["45.000\$", "60.000\$", "120.000\$"],
                onSuggestionSelected: (suggestion) => _selectPrice(suggestion),
                dropdownSearchFieldController: priceController,
              ),
              context.sizeHeight(0.02).heightWidget(),

              // Notas
              MyFitUiKit.widget.form.input(
                label: "Notas (opcional)",
                controller: notesController,
              ),
              context.sizeHeight(0.02).heightWidget(),

              // Estado activo
              Row(
                children: [
                  Checkbox(
                    value: isActive,
                    onChanged: (value) {
                      setState(() {
                        isActive = value ?? false;
                      });
                    },
                    activeColor: MyFitUiKit.util.color.primary,
                  ),
                  Text(
                    "Suscripción activa",
                    style: MyFitUiKit.util.textStyle.text,
                  ),
                ],
              ),
              context.sizeHeight(0.03).heightWidget(),

              // Botones
              Row(
                children: [
                  Expanded(
                    child: MyFitUiKit.widget.button.formButton(
                      ButtonModel(
                        label: "Cancelar",
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: MyFitUiKit.widget.button.formButton(
                      ButtonModel(
                        label: "Guardar",
                        onTap: () => _updateSubscription(context),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectStartDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      initialDate: startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        startDate = date;
        startDateController.text = DateFormat('dd-MMM-yyyy', 'es').format(date);
      });
    }
  }

  void _selectEndDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: startDate,
      initialDate: endDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        endDate = date;
        endDateController.text = DateFormat('dd-MMM-yyyy', 'es').format(date);
      });
    }
  }

  void _selectPrice(String priceText) {
    final priceDouble = double.parse(
      priceText.replaceAll("\$", "").replaceAll(".", ""),
    );
    setState(() {
      price = priceDouble;
      priceController.text = priceDouble.toString();
    });
  }

  void _updateSubscription(BuildContext context) {
    if (startDateController.text.isEmpty ||
        endDateController.text.isEmpty ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Por favor completa todos los campos requeridos"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (endDate.isBefore(startDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "La fecha de fin no puede ser anterior a la fecha de inicio",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Crear la suscripción actualizada
    final updatedSubscription = widget.subscription.copyWith(
      startDate: startDate,
      endDate: endDate,
      price: price,
      notes: notesController.text.isEmpty ? null : notesController.text,
      isActive: isActive,
    );

    widget.cubit.updateSubscription(context, updatedSubscription);
  }
}
