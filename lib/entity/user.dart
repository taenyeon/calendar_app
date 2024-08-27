import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/user.freezed.dart';
part '../generated/entity/user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String username,
    required String name,
    String? imageUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
