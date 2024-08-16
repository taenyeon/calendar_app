abstract class Entity {
  factory Entity.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be overridden');
  }

  Map<String, dynamic> toJson() {
    throw UnimplementedError('toJson must be overridden');
  }
}
