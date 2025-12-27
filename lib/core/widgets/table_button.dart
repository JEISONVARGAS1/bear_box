import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';
import 'package:flutter/cupertino.dart';

class TableButton extends StatelessWidget {
  final bool bold;
  final String label;
  final Color? color;
  final TextAlign align;

  const TableButton({
    super.key,
    this.color,
    this.bold = false,
    required this.label,
    this.align = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        label,
        textAlign: align,
        style: MyFitUiKit.util.textStyle.text.copyWith(
          fontWeight: bold ? FontWeight.bold : null,
          color: color,
        ),
      ),
    );
  }
}
