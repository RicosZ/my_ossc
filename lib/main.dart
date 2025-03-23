import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'constants/colors.dart';

import 'modules/bindings/home_binding.dart';
import 'modules/views/home_view.dart';
import 'routes/app_pages.dart';

Future<void> main() async {
  setPathUrlStrategy();
  await initializeDateFormatting();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ศูนย์ราชการสะดวก',
      debugShowCheckedModeBanner: false,
      //showPerformanceOverlay: true, //กดเปิดเพื่อดูประสิทธิภาพ ms per frame
      theme: Palette.themeData,
      home: const HomeView(),
      initialBinding: HomeBinding(),
      getPages: AppPage.routes,
      locale: const Locale('th', 'TH'),
      fallbackLocale:
          const Locale('th', 'TH'), //หากไม่มีภาษาที่เรียกใช้ให้มาภาษานี้แทน
      supportedLocales: const [Locale('th', 'TH'), Locale('en', 'GB')],
      //localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
