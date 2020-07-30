import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return MaterialApp(
        title: '소득세 계산기',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(children: [
            MyAdmob.createAdmobBanner(adSize: AdmobBannerSize.FULL_BANNER),
            Expanded(child: IncomeTaxCalcPage())
          ])),
        ));
  }
}
