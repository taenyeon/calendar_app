import 'package:calendar_app/util/api/response/entity.dart';

class Empty implements Entity {
  factory Empty._uninstantiable() {
    throw UnsupportedError('class Null cannot be instantiated');
  }

  @override
  String toString() => 'empty';

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnsupportedError('Empty unsupported toJson');
  }
}
