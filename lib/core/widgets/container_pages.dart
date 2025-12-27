import 'package:bearbox/core/extension/context_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class ContainerPages extends StatelessWidget {
  final Widget body;
  final double? height;
  final double? width;

  const ContainerPages({
    super.key,
    this.width,
    this.height,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: context.sizeWidth() * 0.1),
      child: body,
    );
  }
}
