import 'package:calendar_app/constant/calendar_date_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'date.dart';

part '../generated/entity/calendar.freezed.dart';
part '../generated/entity/calendar.g.dart';

@freezed
class Calendar with _$Calendar {
  factory Calendar({
    required int year,
    int? month,
    int? day,
    required CalendarDateType dateType,
    required List<Date> dates,
  }) = _Calendar;

  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);
}
