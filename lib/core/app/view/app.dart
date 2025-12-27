import 'package:bearbox/router.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: MyFitUiKit.util.appThere.getThemeData(),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'BearBox',
    );
  }
}
