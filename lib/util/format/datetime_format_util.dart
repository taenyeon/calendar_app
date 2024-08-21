import 'package:intl/intl.dart';

class DatetimeFormatUtil {
  DatetimeFormatUtil._privateConstructor();

  static DateFormat datetimeFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

  static DateTime toDatetime(String datetime) {
    try {
      return datetimeFormat.parse(datetime);
    } catch (e) {
      throw Exception();
    }
  }

  static String toJson(DateTime dateTime) {
    try {
      return datetimeFormat.format(dateTime);
    } catch (e) {
      throw Exception();
    }
  }
}
