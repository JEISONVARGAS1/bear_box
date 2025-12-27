import 'package:bearbox/core/app/shared_preferences_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bearbox/injection_container.dart' as di;

Future<void> globalSetting() async {
  await EasyLocalization.ensureInitialized();

  di.init();
  await SharedPreferenceManager().initSharedPreference();
}
