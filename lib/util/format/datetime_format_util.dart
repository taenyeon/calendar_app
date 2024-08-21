import 'package:intl/intl.dart';

class DatetimeFormatUtil {
  DatetimeFormatUtil._privateConstructor();

  static DateFormat datetimeFormat = DateFormat('yyyy/MM/dd hh:mm:ss');

  static DateTime toDatetime(String datetime) {
    try {
      return datetimeFormat.parse(datetime);
    } catch (e) {
      throw Exception();
    }
  }
}
