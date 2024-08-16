import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class PlatformUtil {
  // ⭐ The method used when initializing
  static Future<void> settingSize() async {
    if (isDesktop()) {
      await windowManager.ensureInitialized();
      await windowManager.setMinimumSize(const Size(800, 600));
      await windowManager.setMaximumSize(const Size(1280, 832));
    }
  }

  static bool isDesktop() =>
      Platform.isWindows || Platform.isLinux || Platform.isMacOS;

  static bool isMobile() => Platform.isAndroid || Platform.isIOS;
}
