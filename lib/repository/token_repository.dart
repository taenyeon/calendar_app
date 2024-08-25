import 'package:calendar_app/entity/jwt_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class TokenRepository {
  TokenRepository._privateConstructor();

  factory TokenRepository() => _instance;
  static final TokenRepository _instance =
      TokenRepository._privateConstructor();

  final Logger log = Logger('TokenRepository');

  final String _accessTokenKey = 'accessToken';
  final String _refreshTokenKey = 'refreshToken';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Default Function
  Future insert(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future delete(String tokenKey) async =>
      await _secureStorage.delete(key: tokenKey);

  Future<JwtToken> findToken() async => JwtToken(
        accessToken: await findAccessToken(),
        refreshToken: await findRefreshToken(),
      );

  // AccessToken Function
  Future<String?> findAccessToken() async =>
      await _secureStorage.read(key: _accessTokenKey);

  Future insertAccessToken(String value) async =>
      await insert(_accessTokenKey, value);

  Future deleteAccessToken() async => await delete(_accessTokenKey);

  // RefreshToken Function
  Future<String?> findRefreshToken() async =>
      await _secureStorage.read(key: _refreshTokenKey);

  Future insertRefreshToken(String value) async =>
      await insert(_refreshTokenKey, value);

  Future deleteRefreshToken() async => await delete(_refreshTokenKey);

  // Tokens Function
  Future insertToken(JwtToken jwtToken) async {
    log.info('saveAccessToken : ${jwtToken.accessToken}');
    await insertAccessToken(jwtToken.accessToken!);
    log.info('saveRefreshToken : ${jwtToken.refreshToken}');
    await insertRefreshToken(jwtToken.refreshToken!);
  }

  Future deleteToken() async {
    await deleteRefreshToken();
    await deleteAccessToken();
  }
}
