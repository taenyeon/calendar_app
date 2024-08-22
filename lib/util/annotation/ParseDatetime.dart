import 'package:calendar_app/util/format/datetime_format_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonKey(
  fromJson: DatetimeFormatUtil.toDatetime,
  toJson: DatetimeFormatUtil.toJson,
)
const JsonKey Datetime = JsonKey(
  fromJson: DatetimeFormatUtil.toDatetime,
  toJson: DatetimeFormatUtil.toJson,
);
