import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

import './model/use_cases/image_compress.dart';
import './config/custom_theme_data.dart';
import './utils/logger.dart';
import './presentation/pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  late final Directory tempDirectory;
  Logger.configure();

  await Future.wait([
    // 縦固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
    Future(() async {
      tempDirectory = await getTemporaryDirectory();
    }),
  ]);
  // 日本語フォーマット
  await initializeDateFormatting('ja');

  runApp(ProviderScope(
    overrides: [
      imageCompressProvider.overrideWithValue(ImageCompress(tempDirectory))
    ],
    
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: customLightThemeData,
      darkTheme: customDarkThemeData,
      home: const LoginPage(),
    );
  }
}
