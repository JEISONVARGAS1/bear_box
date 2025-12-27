import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';
import 'package:bearbox/core/model/muscle_model.dart';
import 'package:bearbox/core/extension/context_extension.dart';

class MuscleItem extends StatelessWidget {
  final bool isSelected;
  final MusclesModel muscles;
  final Function(MusclesModel) onTap;

  const MuscleItem({
    super.key,
    required this.onTap,
    required this.muscles,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          isSelected
              ? MyFitUiKit.util.color.primary
              : MyFitUiKit.util.color.card,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: () => onTap(muscles),
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.sizeWidth(0.02),
            vertical: context.sizeHeight(0.01),
          ),
          child: Text(
            muscles.name,
            style: MyFitUiKit.util.textStyle.text.copyWith(
              color:
                  isSelected
                      ? MyFitUiKit.util.color.backgroundButton
                      : MyFitUiKit.util.color.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
