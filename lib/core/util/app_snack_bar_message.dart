import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void appSnackBarMessage(
  BuildContext context, {
  required String message,
  bool isSuccess = true,
}) {
  final snackBar = SnackBar(
    content: Text(message).tr(),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
