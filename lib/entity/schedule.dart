import 'package:calendar_app/util/annotation/ParseDatetime.dart';
import 'package:calendar_app/util/format/datetime_format_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/schedule.freezed.dart';
part '../generated/entity/schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    @Datetime required DateTime startDateTime,
    @Datetime required DateTime endDateTime,
    required String title,
    required String text,
    @Datetime required DateTime createdAt,
    @Datetime required DateTime updatedAt,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
