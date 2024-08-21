import 'package:calendar_app/entity/schedule.dart';
import 'package:calendar_app/entity/schedule_of_date.dart';

class ScheduleUtil {
  ScheduleUtil._privateConstructor();

  static List<ScheduleOfDate> getScheduleOfDateList(Schedule schedule) {
    if (_isSameDayEndSchedule(
      startDateTime: schedule.startDateTime,
      endDateTime: schedule.endDateTime,
    )) {
      return <ScheduleOfDate>[
        ScheduleOfDate(
          year: schedule.startDateTime.year,
          month: schedule.startDateTime.month,
          day: schedule.startDateTime.day,
          startHour: schedule.startDateTime.hour,
          startMinute: schedule.startDateTime.minute,
          endHour: schedule.endDateTime.hour,
          endMinute: schedule.endDateTime.minute,
          title: schedule.title,
          text: schedule.text,
          createdAt: schedule.createdAt,
          updatedAt: schedule.updatedAt,
        )
      ];
    }

    return _calculateSchedule(schedule);
  }

  static List<ScheduleOfDate> _calculateSchedule(Schedule schedule) {
    DateTime dateTime = schedule.startDateTime.copyWith();
    List<ScheduleOfDate> scheduleOfDateList = [];
    while (dateTime.isBefore(schedule.endDateTime)) {
      int startHour;
      int startMinute;
      int endHour;
      int endMinute;
      if (dateTime.difference(schedule.endDateTime).inDays == 0) {
        startHour = 0;
        startMinute = 0;
        endHour = schedule.endDateTime.hour;
        endMinute = schedule.endDateTime.minute;
      } else if (dateTime.difference(schedule.startDateTime).inDays == 0) {
        startHour = schedule.startDateTime.hour;
        startMinute = schedule.startDateTime.minute;
        endHour = 23;
        endMinute = 59;
      } else {
        startHour = 0;
        startMinute = 0;
        endHour = 23;
        endMinute = 59;
      }
      scheduleOfDateList.add(ScheduleOfDate(
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          startHour: startHour,
          startMinute: startMinute,
          endHour: endHour,
          endMinute: endMinute,
          title: schedule.title,
          text: schedule.text,
          createdAt: schedule.createdAt,
          updatedAt: schedule.updatedAt));

      dateTime = dateTime.add(const Duration(days: 1));
    }
    return scheduleOfDateList;
  }

  static bool _isSameDayEndSchedule({
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) =>
      startDateTime.difference(endDateTime).inDays == 0;
}
