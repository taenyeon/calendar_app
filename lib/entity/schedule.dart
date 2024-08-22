import 'package:calendar_app/util/annotation/datetime.dart';
import 'package:calendar_app/util/format/datetime_format_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/schedule.freezed.dart';
part '../generated/entity/schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    @DATETIME required DateTime startDateTime,
    @DATETIME required DateTime endDateTime,
    required String title,
    required String text,
    @DATETIME required DateTime createdAt,
    @DATETIME required DateTime updatedAt,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
