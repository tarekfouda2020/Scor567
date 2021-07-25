import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-4105942858270301/4730095963';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-4105942858270301/9408062791';
    }
    throw new UnsupportedError("Unsupported platform");
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-4105942858270301/2634054271";
    } else if (Platform.isIOS) {
      return "ca-app-pub-4105942858270301/7694809266";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
