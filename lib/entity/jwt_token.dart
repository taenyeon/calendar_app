import 'package:calendar_app/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/jwt_token.freezed.dart';
part '../generated/entity/jwt_token.g.dart';

@freezed
class JwtToken with _$JwtToken {
  factory JwtToken({
    String? accessToken,
    String? refreshToken,
  }) = _JwtToken;

  JwtToken._();

  factory JwtToken.fromJson(Map<String, dynamic> json) =>
      _$JwtTokenFromJson(json);

  bool get isAuthorized => refreshToken != null;
}
