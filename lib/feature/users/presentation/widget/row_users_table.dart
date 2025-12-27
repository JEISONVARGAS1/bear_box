import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/widgets/table_button.dart';
import 'package:bearbox/feature/users/data/model/user_table_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class RowUsersTable extends StatelessWidget {
  final UserTableModel user;
  final Function() onTapItem;
  final Function() onTapUpdate;
  final Function() onTapMedical;
  final Function() onTapDelete;
  final bool isLoading;

  const RowUsersTable({
    super.key,
    required this.user,
    required this.onTapItem,
    required this.onTapUpdate,
    required this.onTapMedical,
    required this.onTapDelete,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapItem,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: context.sizeWidth() * 0.007),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: MyFitUiKit.util.color.textColor),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(flex: 2, child: TableButton(label: user.name)),
              Expanded(flex: 2, child: TableButton(label: user.email)),
              Expanded(flex: 1, child: TableButton(label: user.phone)),
              Expanded(
                flex: 1,
                child: TableButton(
                  color:
                      user.dateSubscription!
                          .copyWith(month: user.dateSubscription!.month + 1)
                          .isBefore(DateTime.now())
                      ? MyFitUiKit.util.color.delete
                      : null,
                  label: user.dateSubscription != null
                      ? "${DateFormat('dd-MMM-yyyy', 'es').format(user.dateSubscription!)} / ${DateFormat('dd-MMM-yyyy', 'es').format(user.dateSubscription!.copyWith(month: user.dateSubscription!.month + 1))}"
                      : "No tiene suscripción",
                ),
              ),
              Expanded(
                flex: 1,
                child: TableButton(
                  label: NumberFormat.currency(
                    locale: 'es_CO',
                    symbol: '\$',
                    decimalDigits: 0,
                  ).format(user.priceSubscription),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyFitUiKit.widget.button.smallStandardButton(
                      onTap: onTapUpdate,
                      icon: Icons.edit,
                    ),
                    MyFitUiKit.widget.button.smallStandardButton(
                      onTap: isLoading ? () {} : onTapMedical,
                      icon: isLoading
                          ? Icons.hourglass_empty
                          : Icons.medical_information,
                    ),
                    MyFitUiKit.widget.button.smallStandardButton(
                      onTap: onTapDelete,
                      icon: Icons.delete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
