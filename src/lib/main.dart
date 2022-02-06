import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:income_tax_calc/my_admob.dart';
import 'package:little_easy_admob/little_easy_admob.dart';

import 'income_tax_calc_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// AdMob 초기화
  MyAdmob.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // AppOpen 광고 설정
    AppOpenAdManager appOpenAdManager = AppOpenAdManager(MyAdmob.unitIdAppOpen)
      ..loadAd();
    WidgetsBinding.instance!
        .addObserver(AppLifecycleReactor(appOpenAdManager: appOpenAdManager));
  }

  @override
  Widget build(BuildContext context) {
    /// https://gs.statcounter.com/screen-resolution-stats/mobile/south-korea
    /// 2021년 정보 참고 : 412 X 869 화면비 2.11 : 1 비율로 계산하여
    /// 최종 : 360x760 으로 정함.
    const designSize = Size(360, 760);

    // Prevent device orientation changes.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final ad = MyAdmob.createBannerAd();
    return ScreenUtilInit(
      designSize: designSize,
      builder: () {
        return GetMaterialApp(
          title: '소득세 계산기',
          theme: ThemeData(
            primarySwatch: Colors.grey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Builder(
            builder: (context) {
              ScreenUtil.setContext(context);
              return Scaffold(
                  body: SafeArea(
                      child: Column(children: [
                Expanded(
                    child: IncomeTaxCalcPage(
                  adBanner: ad,
                )),
                ad
              ])));
            },
          ),
        );
      },
    );
  }
}
