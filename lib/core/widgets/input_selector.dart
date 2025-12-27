import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class InputSelector extends StatelessWidget {
  final String value;
  final double dropdownPadding;
  final Function(String?) onTap;
  final List<String> listElement;

  const InputSelector({
    super.key,
    required this.onTap,
    required this.value,
    required this.listElement,
    required this.dropdownPadding,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        value: value,
        hint: const Row(
          children: [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.black,
            ),
            SizedBox(
              width: 4,
            ),
            
          ],
        ),
        items: listElement
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  "Hola mundo",
                  style: MyFitUiKit.util.textStyle.text,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onTap,
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: MyFitUiKit.util.color.textColor),
          ),
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down_rounded),
          iconSize: 20,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          width: dropdownPadding,
          decoration: BoxDecoration(
            color: MyFitUiKit.util.color.backgroundButton,
            borderRadius: BorderRadius.circular(14),
          ),
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
