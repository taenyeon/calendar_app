import 'dart:async';

import 'package:calendar_app/util/log/logging_util.dart';
import 'package:calendar_app/util/platform/platform_util.dart';
import 'package:calendar_app/util/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LoggingUtil.settingLogger();

  // await PlatformUtil.settingSize();

  await dotenv.load();

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'calendar',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        dividerTheme: const DividerThemeData(color: Colors.transparent),
        fontFamily: 'Pretendard',
      ),
      routerConfig: router,
    );
  }
}
