const String assetsPath = 'assets/translations';

enum Preferences {
  EXPLORE,
  FOLLOWED,
}



class StripeConstants{
  static String country = "ES";
  static String currency = "EUR";
  static String stripeLink = "https://api.stripe.com/v1/payment_intents";
}

class AppConstants{
  static String appName = "Veomi";
  static String hiveConstantsUser = 'user';
}

String iconsAssets(String item) => "assets/icons/$item";
String imagesAssets(String item) => "assets/images/$item";

String stripeUrl(String item) => 'https://us-central1-veomidev.cloudfunctions.net/$item';
String basicStripeUrl(String item) => 'https://api.stripe.com/v1/$item';
