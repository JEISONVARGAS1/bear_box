import 'package:flutter/cupertino.dart';

extension DoubleExtension on double {
  Widget widthWidget() => SizedBox(width: this);
  Widget heightWidget() => SizedBox(height: this);
}
