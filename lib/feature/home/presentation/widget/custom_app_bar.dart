import 'package:bearbox/core/extension/context_extension.dart';
import 'package:bearbox/core/extension/manu_options_extension.dart';
import 'package:bearbox/feature/home/data/model/menu_enum.dart';
import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function() onTapLogout;
  final MenuOptions valueSelected;
  final List<MenuOptions> menuOptions;
  final Function(MenuOptions) onTapMenu;

  const CustomAppBar({
    super.key,
    required this.onTapMenu,
    required this.menuOptions,
    required this.onTapLogout,
    required this.valueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: Text(
        "Bearbox",
        style: MyFitUiKit.util.textStyle.title.copyWith(
          color: MyFitUiKit.util.color.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: context.sizeWidth() * 0.01),
          child: Row(
            children: List.generate(
              menuOptions.length,
              (index) => _buttonMenu(
                menuOptions[index],
                valueSelected,
                () => onTapMenu(menuOptions[index]),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: context.sizeWidth() * 0.1),
          child: IconButton(
            onPressed: onTapLogout,
            icon: MaterialButton(
              onPressed: onTapLogout,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: MyFitUiKit.util.color.primary,
              child: const Icon(Icons.logout, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

  _buttonMenu(MenuOptions label, MenuOptions valueSelected, Function() onTap) =>
      InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: label == valueSelected
                    ? MyFitUiKit.util.color.primary
                    : Colors.transparent,
              ),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Text(
            label.toName,
            style: MyFitUiKit.util.textStyle.text.copyWith(
              color: label == valueSelected
                  ? MyFitUiKit.util.color.primary
                  : MyFitUiKit.util.color.textColor,
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
