import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:income_tax_calc/my_admob.dart';

import 'income_tax_calc_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// AdMob 초기화
  MyAdmob.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Prevent device orientation changes.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final ad = MyAdmob.createAdmobBanner(adSize: AdmobBannerSize.BANNER);
    return GetMaterialApp(
        title: '소득세 계산기',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            body: SafeArea(
                child: Column(children: [
          Expanded(
              child: IncomeTaxCalcPage(
            adBanner: ad,
          )),
          ad
        ]))));
  }
}
