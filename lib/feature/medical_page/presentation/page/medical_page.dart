import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/extension/double_extension.dart';
import 'package:bearbox/feature/medical_page/presentation/cubit/medical_page_cubit.dart';
import 'package:bearbox/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/models/button_model.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class MedicalPage extends BasePage<MedicalPageState, MedicalPageCubit> {
  final UserModel user;

  const MedicalPage({super.key, required this.user});

  @override
  MedicalPageCubit createBloc(BuildContext context) =>
      sl<MedicalPageCubit>()..init(context, user);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: context.sizeWidth(),
        height: context.sizeHeight(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: context.sizeWidth(0.05),
            vertical: context.sizeHeight(0.02),
          ),
          child: Form(
            key: state.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Información Médica",
                  style: MyFitUiKit.util.textStyle.titleXL.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.02).heightWidget(),
                Text(
                  "Usuario: ${user.name}",
                  style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                context.sizeHeight(0.1).heightWidget(),

                // Medidas básicas
                Text(
                  "Medidas Básicas",
                  style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.01).heightWidget(),
                Divider(thickness: 1, color: MyFitUiKit.util.color.white),
                context.sizeHeight(0.01).heightWidget(),

                MyFitUiKit.widget.form.input(
                  label: "Altura (Metros)",
                  validator: bloc.validateHeight,
                  controller: state.heightController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Peso (kg)",
                  validator: bloc.validateWeight,
                  controller: state.weightController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "BMI",
                  controller: state.bmiController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.03).heightWidget(),

                // Composición corporal
                Text(
                  "Composición Corporal",
                  style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.01).heightWidget(),
                Divider(thickness: 1, color: MyFitUiKit.util.color.white),
                context.sizeHeight(0.01).heightWidget(),

                MyFitUiKit.widget.form.input(
                  label: "Grasa corporal (%)",
                  controller: state.fatPercentageController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Músculo (%)",
                  controller: state.musclePercentageController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "RM kcal",
                  controller: state.rmKcalController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Edad corporal",
                  controller: state.bodyAgeController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Grasa visceral",
                  controller: state.visceralFatController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.03).heightWidget(),

                // Signos vitales
                Text(
                  "Signos Vitales",
                  style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.01).heightWidget(),
                Divider(thickness: 1, color: MyFitUiKit.util.color.white),
                context.sizeHeight(0.01).heightWidget(),

                MyFitUiKit.widget.form.input(
                  label: "FC reposo (bpm)",
                  controller: state.restingHeartRateController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "SO2 (%)",
                  controller: state.so2PercentageController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Presión arterial sistólica",
                  controller: state.systolicPressureController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Presión arterial diastólica",
                  controller: state.diastolicPressureController,
                  keyboardType: TextInputType.number,
                ),
                context.sizeHeight(0.03).heightWidget(),

                // Antecedentes médicos
                Text(
                  "Antecedentes Médicos",
                  style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.01).heightWidget(),
                Divider(thickness: 1, color: MyFitUiKit.util.color.white),
                context.sizeHeight(0.01).heightWidget(),

                MyFitUiKit.widget.form.dropdownWritableInput(
                  label: "Antecedentes de enfermedades",
                  hintText: "Selecciona una opción",
                  items: ["SI", "NO"],
                  onSuggestionSelected: (suggestion) =>
                      bloc.selectDiseases(suggestion),
                  dropdownSearchFieldController: TextEditingController(
                    text: state.hasDiseases,
                  ),
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.dropdownWritableInput(
                  label: "Dolores",
                  hintText: "Selecciona una opción",
                  items: ["SI", "NO"],
                  onSuggestionSelected: (suggestion) =>
                      bloc.selectPain(suggestion),
                  dropdownSearchFieldController: TextEditingController(
                    text: state.hasPain,
                  ),
                ),
                context.sizeHeight(0.02).heightWidget(),
                MyFitUiKit.widget.form.input(
                  maxLine: 5,
                  label: "Observación médica",
                  controller: state.medicalObservationController,
                ),

                SizedBox(height: context.sizeHeight(0.05)),
                state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyFitUiKit.util.color.textColor,
                        ),
                      )
                    : MyFitUiKit.widget.button.formButton(
                        ButtonModel(
                          label: "Guardar",
                          onTap: () => bloc.saveMedicalData(context),
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
