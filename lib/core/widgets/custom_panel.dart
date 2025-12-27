import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';
import 'package:bearbox/core/extension/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CustomPanel extends StatelessWidget {
  final Widget body;
  final double? maxHeight;
  final PanelController controller;
  final Widget Function(ScrollController sc) panel;

  const CustomPanel({
    super.key,
    this.maxHeight,
    required this.body,
    required this.panel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      body: body,
      minHeight: 0,
      color: MyFitUiKit.util.color.backgroundButton,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      panelBuilder: panel,
      parallaxEnabled: true,
      backdropEnabled: true,
      controller: controller,
      backdropTapClosesPanel: true,
      maxHeight: maxHeight ?? context.sizeHeight() * 0.7,
    );
  }
}
