import 'package:calendar_app/entity/schedule_of_date.dart';
import 'package:calendar_app/util/annotation/datetime.dart';
import 'package:calendar_app/util/format/datetime_format_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/schedule.freezed.dart';
part '../generated/entity/schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    required int id,
    @DATETIME required DateTime startedAt,
    @DATETIME required DateTime endedAt,
    required String title,
    required String text,
    @DATETIME required DateTime createdAt,
    @DATETIME required DateTime updatedAt,
  }) = _Schedule;

  Schedule._();

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  bool _isSameDayEndSchedule() => startedAt.difference(endedAt).inDays == 0;

  List<ScheduleOfDate> getScheduleOfDateList() {
    if (_isSameDayEndSchedule()) {
      return [
        ScheduleOfDate(
          id: id,
          year: startedAt.year,
          month: startedAt.month,
          day: startedAt.day,
          startHour: startedAt.hour,
          startMinute: startedAt.minute,
          endHour: endedAt.hour,
          endMinute: endedAt.minute,
          title: title,
          text: text,
          createdAt: createdAt,
          updatedAt: updatedAt,
        )
      ];
    }

    return _calculateSchedule();
  }

  List<ScheduleOfDate> _calculateSchedule() {
    DateTime dateTime = startedAt.copyWith();
    List<ScheduleOfDate> scheduleOfDateList = [];
    while (dateTime.isBefore(endedAt)) {
      int startHour;
      int startMinute;
      int endHour;
      int endMinute;
      if (dateTime.difference(endedAt).inDays == 0) {
        startHour = 0;
        startMinute = 0;
        endHour = endedAt.hour;
        endMinute = endedAt.minute;
      } else if (dateTime.difference(startedAt).inDays == 0) {
        startHour = startedAt.hour;
        startMinute = startedAt.minute;
        endHour = 23;
        endMinute = 59;
      } else {
        startHour = 0;
        startMinute = 0;
        endHour = 23;
        endMinute = 59;
      }
      scheduleOfDateList.add(ScheduleOfDate(
          id: id,
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          startHour: startHour,
          startMinute: startMinute,
          endHour: endHour,
          endMinute: endMinute,
          title: title,
          text: text,
          createdAt: createdAt,
          updatedAt: updatedAt));

      dateTime = dateTime.add(const Duration(days: 1));
    }
    return scheduleOfDateList;
  }
}
