import 'package:calendar_app/constant/weekday.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class Date {
  factory Date({
    required int year,
    required int month,
    required int day,
    required Weekday weekday,
  }) = _Date;
}
