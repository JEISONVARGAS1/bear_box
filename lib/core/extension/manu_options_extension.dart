import 'package:bearbox/feature/home/data/model/menu_enum.dart';

extension MenuOptionsExtension on MenuOptions {
  String get toName => switch (this) {
    MenuOptions.USERS => 'Usuarios',
    MenuOptions.SUBSCRIPTIONS => 'Suscripciones',
  };
}
