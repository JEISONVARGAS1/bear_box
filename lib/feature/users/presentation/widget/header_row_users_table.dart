import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/widgets/table_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class HeaderRowUsersTable extends StatelessWidget {
  const HeaderRowUsersTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.sizeWidth() * 0.007),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MyFitUiKit.util.color.textColor),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: TableButton(label: "Name", bold: true)),
          Expanded(flex: 2, child: TableButton(label: "Email", bold: true)),
          Expanded(flex: 1, child: TableButton(label: "Teléfono", bold: true)),
          Expanded(
            flex: 1,
            child: TableButton(label: "Fecha de suscripción", bold: true),
          ),
          Expanded(
            flex: 1,
            child: TableButton(label: "Precio de la suscripción", bold: true),
          ),
          Expanded(
            flex: 1,
            child: TableButton(
              label: "Actions",
              bold: true,
              align: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
