import 'package:calendar_app/util/exception/error.dart';

class ErrorException implements Exception {
  ErrorException(this.error);

  ErrorCase error;

  @override
  String toString() {
    return '[Error] code: ${error.code}\n message: ${error.message}';
  }
}
