import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/util/entity/example_entity.g.dart';

part '../../generated/util/entity/example_entity.freezed.dart';

@freezed
class ExampleEntity with _$ExampleEntity {
  factory ExampleEntity({
    required String a,
    required String b,
  }) = _ExampleEntity;

  factory ExampleEntity.fromJson(Map<String, dynamic> json) => _$ExampleEntityFromJson(json);
}
