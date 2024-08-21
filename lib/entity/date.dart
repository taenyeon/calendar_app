import 'package:calendar_app/constant/weekday.dart';
import 'package:calendar_app/entity/schedule_of_date.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/date.freezed.dart';
part '../generated/entity/date.g.dart';

@freezed
class Date with _$Date {
  factory Date({
    required int year,
    required int month,
    required int day,
    required Weekday weekday,
    required List<ScheduleOfDate> schedules,
  }) = _Date;

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);
}
