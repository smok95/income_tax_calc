import 'dart:io';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/material.dart';
import 'package:little_easy_admob/little_easy_admob.dart';

import 'my_private_data.dart';

class MyAdmob {
  /// {@template firebase_admob.testAdUnitId}
  /// A platform-specific AdMob test ad unit ID. This ad unit
  /// has been specially configured to always return test ads, and developers
  /// are encouraged to use it while building and testing their apps.
  /// {@endtemplate}
  /// {@macro firebase_admob.testAdUnitId}
  /// [package:firebase_admob/firebase_admob.dart]에서 발췌함.
  static final String testAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  static String get appId => MyPrivateData.adMobAppId;
  static String get unitId {
    return Foundation.kDebugMode
        ? testAdUnitId
        : MyPrivateData.adMobUnitIdBanner1;
  }

  /// AppOpen 광고 단위 ID
  static String get unitIdAppOpen {
    return Foundation.kDebugMode
        ? 'ca-app-pub-3940256099942544/3419835294'
        : MyPrivateData.adMobUnitIdAppOpen1;
  }

  /// Admob 배너 생성
  static Widget createBannerAd() {
    return AnchoredAdaptiveBannerAdWidget(adUnitId: unitId);
  }

  static void initialize() async {
    await LittleEasyAdmob.initialize(requestTrackingAuthorization: true);
  }
}
