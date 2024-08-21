import 'package:calendar_app/util/format/datetime_format_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/schedule.freezed.dart';
part '../generated/entity/schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    @JsonKey(
      fromJson: DatetimeFormatUtil.toDatetime,
      toJson: DatetimeFormatUtil.toJson,
    )
    required DateTime startDateTime,
    @JsonKey(
      fromJson: DatetimeFormatUtil.toDatetime,
      toJson: DatetimeFormatUtil.toJson,
    )
    required DateTime endDateTime,
    required String title,
    required String text,
    @JsonKey(
      fromJson: DatetimeFormatUtil.toDatetime,
      toJson: DatetimeFormatUtil.toJson,
    )
    required DateTime createdAt,
    @JsonKey(
      fromJson: DatetimeFormatUtil.toDatetime,
      toJson: DatetimeFormatUtil.toJson,
    )
    required DateTime updatedAt,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
