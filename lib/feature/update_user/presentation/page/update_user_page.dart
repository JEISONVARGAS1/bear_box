import 'package:bearbox/core/base/base_page.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/extension/double_extension.dart';
import 'package:bearbox/feature/update_user/presentation/cubit/update_user_cubit.dart';
import 'package:bearbox/feature/update_user/presentation/widget/subscription_card.dart';
import 'package:bearbox/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:my_fit_ui_kit/models/button_model.dart';
import 'package:my_fit_ui_kit/models/user_model.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class UpdateUserPage extends BasePage<UpdateUserState, UpdateUserCubit> {
  final UserModel user;

  const UpdateUserPage({super.key, required this.user});

  @override
  UpdateUserCubit createBloc(BuildContext context) =>
      sl<UpdateUserCubit>()..init(context, user);

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
                  "Actualizar usuario",
                  style: MyFitUiKit.util.textStyle.titleXL.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Name",
                  validator: bloc.validateName,
                  controller: state.nameController,
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
                  label: "Direccion",
                  controller: state.addressController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  maxLine: 5,
                  label: "Descripcion de la direccion",
                  controller: state.addressDescriptionController,
                ),
                context.sizeHeight(0.03).heightWidget(),
                MyFitUiKit.widget.form.input(
                  label: "Numero cel",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Suscripción de gimnasio",
                      style: MyFitUiKit.util.textStyle.subTitle.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Material(
                      color: MyFitUiKit.util.color.primary,
                      shape: CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: InkWell(
                          customBorder: CircleBorder(),
                          onTap: () => bloc.openSubscriptionPopup(context),
                          child: Icon(
                            Icons.add,
                            color: MyFitUiKit.util.color.cardDark,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                context.sizeHeight(0.01).heightWidget(),
                Divider(thickness: 1, color: MyFitUiKit.util.color.white),
                context.sizeHeight(0.01).heightWidget(),

                state.subscriptionsActive.isNotEmpty
                    ? SizedBox(
                        width: context.sizeWidth(),
                        height: context.sizeHeight(0.25),
                        child: FlutterCarousel.builder(
                          itemCount: state.subscriptionsActive.length,
                          itemBuilder: (context, index, realIndex) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              child: SubscriptionCard(
                                subscription: state.subscriptionsActive[index],
                                cubit: bloc,
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: context.sizeHeight(0.25),
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(
                              milliseconds: 800,
                            ),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      )
                    : Center(child: Text("No hay suscripciones")),

                SizedBox(height: context.sizeHeight(0.07)),
                state.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: MyFitUiKit.util.color.textColor,
                        ),
                      )
                    : MyFitUiKit.widget.button.formButton(
                        ButtonModel(
                          label: "Save",
                          onTap: () => bloc.updateExercise(context),
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
