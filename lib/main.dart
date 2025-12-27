import 'package:bearbox/core/app/shared_preferences_manager.dart';
import 'package:bearbox/core/app/view/app.dart';
import 'package:bearbox/core/app/view/global_setting.dart';
import 'package:bearbox/core/util/app_constants.dart';
import 'package:bearbox/core/util/flutterlab_support_locales.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Inicializar SharedPreferences primero
    await SharedPreferenceManager().initSharedPreference();
    // SharedPreferences initialized successfully

    // Inicializar Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Firebase initialized successfully

    // Inicializar datos de localización para DateFormat
    await initializeDateFormatting('es');

    // Luego inicializar configuraciones globales
    await globalSetting();
    // Global settings initialized successfully

    runApp(
      EasyLocalization(
        path: assetsPath,
        fallbackLocale: FlutterLabSupportLocales.spanish,
        supportedLocales: FlutterLabSupportLocales.supportedLocales(),
        child: const App(),
      ),
    );
  } catch (e) {
    // Error in main: $e

    // Intentar inicializar SharedPreferences incluso si hay otros errores
    try {
      await SharedPreferenceManager().initSharedPreference();
      // SharedPreferences initialized in catch block
    } catch (spError) {
      // Error initializing SharedPreferences: $spError
    }

    // Intentar inicializar DateFormat incluso si hay otros errores
    try {
      await initializeDateFormatting('es');
      // Date formatting initialized in catch block
    } catch (dateError) {
      // Error initializing date formatting: $dateError
    }

    // Si hay error, intentar ejecutar sin Firebase
    runApp(
      EasyLocalization(
        path: assetsPath,
        fallbackLocale: FlutterLabSupportLocales.spanish,
        supportedLocales: FlutterLabSupportLocales.supportedLocales(),
        child: const App(),
      ),
    );
  }
}
