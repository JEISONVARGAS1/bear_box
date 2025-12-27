import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double sizeWidth([double? size]) => size != null ? size * MediaQuery.of(this).size.width :MediaQuery.of(this).size.width;
  double sizeHeight([double? size]) => size != null ? size * MediaQuery.of(this).size.height : MediaQuery.of(this).size.height;
}
