import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/schedule.freezed.dart';
part '../generated/entity/schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  factory Schedule({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required String title,
    required String text,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Schedule;

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
}
