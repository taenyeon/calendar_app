import 'package:intl/intl.dart';

class DatetimeFormatUtil {
  DatetimeFormatUtil._privateConstructor();

  factory DatetimeFormatUtil() => _instance;
  static final DatetimeFormatUtil _instance = DatetimeFormatUtil._privateConstructor();

  static DateFormat datetimeFormat = DateFormat('yyyy/MM/dd hh:mm:ss');

  static DateTime toDatetime(String datetime) {
    try {
      return datetimeFormat.parse(datetime);
    } catch (e) {
      throw Exception();
    }
  }
}
