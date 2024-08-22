import 'package:calendar_app/util/annotation/datetime.dart';
import 'package:calendar_app/util/format/datetime_format_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/schedule_of_date.freezed.dart';
part '../generated/entity/schedule_of_date.g.dart';

@freezed
class ScheduleOfDate with _$ScheduleOfDate {
  factory ScheduleOfDate({
    required int id,
    // 날짜
    required int year,
    required int month,
    required int day,

    // 시작 시간
    required int startHour,
    required int startMinute,

    // 종료 시간
    required int endHour,
    required int endMinute,

    // 본문
    required String title,
    required String text,

    // 생성 일자
    @DATETIME required DateTime createdAt,
    // 수정 일자
    @DATETIME required DateTime updatedAt,
  }) = _ScheduleOfDate;

  factory ScheduleOfDate.fromJson(Map<String, dynamic> json) =>
      _$ScheduleOfDateFromJson(json);
}
