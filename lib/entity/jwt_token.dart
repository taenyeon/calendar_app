import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/entity/jwt_token.g.dart';

part '../generated/entity/jwt_token.freezed.dart';

@freezed
class JwtToken with _$JwtToken {
  factory JwtToken({
    String? accessToken,
    String? refreshToken,
  }) = _JwtToken;

  JwtToken._();

  factory JwtToken.fromJson(Map<String, dynamic> json) =>
      _$JwtTokenFromJson(json);

  bool get isAutholized => refreshToken != null;
}
