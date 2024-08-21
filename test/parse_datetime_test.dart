import 'package:calendar_app/entity/date.dart';
import 'package:calendar_app/entity/schedule.dart';
import 'package:calendar_app/entity/schedule_of_date.dart';
import 'package:calendar_app/repository/calendar_repository.dart';
import 'package:calendar_app/util/schedule/schedule_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

void main() {
  final Logger log = Logger('test');

  test('test', () {
    var value = 'foo,bar,baz';
    expect(value.split(','), equals(['foo', 'bar', 'baz']));
  });

  test('parse_datetime', () {
    DateTime datetime =
        DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/1 00:00:00');
    expect(datetime.weekday, equals(4));
    int month = datetime.month + 1;
    List<Map<String, dynamic>> dates = [];
    while (datetime.month < month) {
      dates.add({
        'year': datetime.year,
        'month': datetime.month,
        'day': datetime.day,
        'hour': datetime.hour,
        'minute': datetime.minute,
        'second': datetime.second,
        'weekday.dart': datetime.weekday
      });
      datetime = datetime.add(const Duration(days: 1));
    }
    for (Map<String, dynamic> date in dates) {
      print('$date\n');
    }
  });

  test('find_between_datetimes', () {
    DateTime startDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/14 07:00:00');
    DateTime endDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/16 15:00:00');

    DateTime dateTime = startDateTime.copyWith();
    List<Map<String, dynamic>> dates = [];
    while (dateTime.isBefore(endDateTime)) {
      Map<String, dynamic> calendar;
      if (dateTime.difference(endDateTime).inDays == 0) {
        calendar = {
          'startDateTime':
              endDateTime.copyWith(hour: 00, minute: 00, second: 00),
          'endDateTime': endDateTime,
        };
      } else if (dateTime.difference(startDateTime).inDays == 0) {
        calendar = {
          'startDateTime': startDateTime,
          'endDateTime':
              startDateTime.copyWith(hour: 23, minute: 59, second: 59),
        };
      } else {
        calendar = {
          'startDateTime': dateTime.copyWith(hour: 0, minute: 0, second: 0),
          'endDateTime': dateTime.copyWith(hour: 23, minute: 59, second: 59),
        };
      }
      dates.add(calendar);
      dateTime = dateTime.add(const Duration(days: 1));
    }
    for (Map<String, dynamic> date in dates) {
      print('$date\n');
    }
  });

  test('schedule_util_test', () {
    DateTime startDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/14 07:00:00');
    DateTime endDateTime =
        DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/16 15:00:00');
    Schedule schedule = Schedule(
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      title: 'hello',
      text: 'world',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    List<ScheduleOfDate> scheduleOfDateList =
        ScheduleUtil.getScheduleOfDateList(schedule);

    for (ScheduleOfDate scheduleOfDate in scheduleOfDateList) {
      log.info(scheduleOfDate);
    }
  });

  test('calendar_repository_test', () {
    CalendarRepository calendarRepository = CalendarRepository();
    List<Date> dates = calendarRepository.findByYearAndMonth(2023, 8);
    print('dates : ');
    for (Date element in dates) {
      print(element);
    }
  });

  test('parse_json_test', () {
    Map<String, dynamic> json = {
      'startDateTime': '2024/08/08 00:00:00',
      'endDateTime': '2024/08/08 00:00:00',
      'title': '',
      'text': '',
      'createdAt': '2024/08/08 00:00:00',
      'updatedAt': '2024/08/08 00:00:00',
    };

    Schedule schedule = Schedule.fromJson(json);

    print(schedule);
    print(schedule.toJson());
  });
}
