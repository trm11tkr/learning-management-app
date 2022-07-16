import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import './presentation/pages/tabs_page.dart';
import './config/custom_theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    // 縦固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  ]);
  // 日本語フォーマット
  await initializeDateFormatting('ja');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customLightThemeData,
      darkTheme: customDarkThemeData,
      home: const TabsPage(),
    );
  }
}
