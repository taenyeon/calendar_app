import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

class LoggingUtil {
  static Logger logger(String title) => Logger(title);

  // ⭐ The method used when initializing
  static void settingLogger() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('✈️ ${record.time}'
            ' - '
            '${LoggingUtil.getLogLevel(record.level)} '
            '[SEQ : ${record.sequenceNumber}] '
            '\x1B[34m${record.loggerName}\x1B[0m'
            ' : '
            '${record.message}');
      }
    });
  }

  static String getLogLevel(Level level) {
    switch (level) {
      case Level.INFO:
        return '\x1B[32mINFO\x1B[0m';
      case Level.WARNING:
        return '\x1B[33mWARNING\x1B[0m';
      case Level.SEVERE:
        return '\x1B[31mERROR\x1B[0m';
      default:
        return '\x1B[31mERROR\x1B[0m';
    }
  }

  static String getPrettyJson(Map<String, dynamic>? object) {
    if (object != null && object.isNotEmpty) {
      const jsonEncoder = JsonEncoder.withIndent('  ');
      return jsonEncoder.convert(object);
    }
    return 'is null or empty or error';
  }

  static String getPrettyString(Map<String, dynamic> object) {
    StringBuffer stringBuffer = StringBuffer();
    object.forEach((key, value) {
      stringBuffer.writeln('$key: $value');
    });
    return stringBuffer.toString();
  }
}
