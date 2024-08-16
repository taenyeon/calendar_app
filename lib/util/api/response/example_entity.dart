import 'package:calendar_app/util/api/response/entity.dart';

class ExampleEntity implements Entity {
  ExampleEntity({
    required this.a,
    required this.b,
  });

  @override
  factory ExampleEntity.fromJson(Map<String, dynamic> json) {
    return ExampleEntity(
      a: json['a'],
      b: json['b'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['a'] = a;
    json['b'] = b;
    return json;
  }

  final String a;
  final String b;
}
