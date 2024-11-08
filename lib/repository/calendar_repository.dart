import 'package:calendar_app/constant/weekday.dart';
import 'package:calendar_app/entity/date.dart';
import 'package:calendar_app/entity/schedule_of_date.dart';
import 'package:calendar_app/util/exception/error.dart';
import 'package:calendar_app/util/exception/error_exception.dart';
import 'package:logging/logging.dart';

class CalendarRepository {
  CalendarRepository._privateConstructor();

  factory CalendarRepository() => _instance;
  static final CalendarRepository _instance =
      CalendarRepository._privateConstructor();

  final Logger log = Logger('CalendarRepository');

  List<Date> findByMonth(int month) {
    // validation
    DateTime now = DateTime.now();

    if (month <= 0 || month > 12) throw Exception('not valid parameter');

    List<Date> dates = [];

    DateTime startDateTime = DateTime(now.year, month, 1);
    int endMonth = startDateTime.month + 1;

    // todo schedule을 받아오는 API 추가 필요.
    List<ScheduleOfDate> schedules = [];

    while (startDateTime.month < endMonth) {
      Date date = Date(
          year: startDateTime.year,
          month: startDateTime.month,
          day: startDateTime.day,
          weekday: Weekday.getByValue(startDateTime.weekday),
          schedules: schedules);

      for (ScheduleOfDate schedule in schedules) {
        // if 문이 조금 어색해보임
        if (schedule.year == date.year &&
            schedule.month == date.month &&
            schedule.day == date.day) {
          date.schedules.add(schedule);
        }
      }
      // 날짜 증가
      startDateTime = startDateTime.add(const Duration(days: 1));
      dates.add(date);
    }
    return dates;
  }

  List<Date> findByYearAndMonth(int year, int month) {
    // validation
    if (month <= 0 || month > 12) throw Exception('not valid parameter');

    List<Date> dates = [];

    DateTime startDateTime = DateTime(year, month, 1);
    if (startDateTime.weekday > 1) {
      startDateTime =
          startDateTime.subtract(Duration(days: startDateTime.weekday - 1));
    }
    log.info(startDateTime);

    // todo schedule을 받아오는 API 추가 필요.
    List<ScheduleOfDate> schedules = [];

    while (dates.length != 35) {
      Date date = Date(
          year: startDateTime.year,
          month: startDateTime.month,
          day: startDateTime.day,
          weekday: Weekday.getByValue(startDateTime.weekday),
          schedules: schedules);

      for (ScheduleOfDate schedule in schedules) {
        // if 문이 조금 어색해보임
        if (schedule.year == date.year &&
            schedule.month == date.month &&
            schedule.day == date.day) {
          date.schedules.add(schedule);
        }
      }
      // 날짜 증가
      startDateTime = startDateTime.add(const Duration(days: 1));
      dates.add(date);
    }
    return dates;
  }

  List<Date> findByYear(int year) {
    List<Date> dates = [];

    DateTime startDateTime = DateTime(year, 1, 1);
    int endYear = startDateTime.year + 1;
    // todo schedule을 받아오는 API 추가 필요.
    List<ScheduleOfDate> schedules = [];

    while (startDateTime.year < endYear) {
      Date date = Date(
          year: startDateTime.year,
          month: startDateTime.month,
          day: startDateTime.day,
          weekday: Weekday.getByValue(startDateTime.weekday),
          schedules: schedules);

      for (ScheduleOfDate schedule in schedules) {
        // if 문이 조금 어색해보임
        if (schedule.year == date.year &&
            schedule.month == date.month &&
            schedule.day == date.day) {
          date.schedules.add(schedule);
        }
      }
      // 날짜 증가
      startDateTime = startDateTime.add(const Duration(days: 1));
      dates.add(date);
    }
    return dates;
  }

  List<Date> findByYearAndMonthAndDay(int year, int month, int day) {
    // validation
    if (month <= 0 || month > 12) throw ErrorException(ErrorCase.invalidParam);
    if (day > 31) throw ErrorException(ErrorCase.invalidParam);

    List<Date> dates = [];

    DateTime startDateTime = DateTime(year, month, day);

    // todo schedule을 받아오는 API 추가 필요.
    List<ScheduleOfDate> schedules = [];

    Date date = Date(
        year: startDateTime.year,
        month: startDateTime.month,
        day: startDateTime.day,
        weekday: Weekday.getByValue(startDateTime.weekday),
        schedules: []);

    for (ScheduleOfDate schedule in schedules) {
      // if 문이 조금 어색해보임
      if (schedule.year == date.year &&
          schedule.month == date.month &&
          schedule.day == date.day) {
        date.schedules.add(schedule);
      }
    }
    // 날짜 증가
    dates.add(date);

    return dates;
  }
}
