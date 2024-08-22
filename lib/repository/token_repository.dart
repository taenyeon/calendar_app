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
    await delete(key);
    await _secureStorage.write(key: key, value: value);
  }

  Future delete(String tokenKey) async =>
      await _secureStorage.delete(key: tokenKey);

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
  Future insertToken(String accessToken, String refreshToken) async {
    log.info('saveAccessToken : $accessToken');
    await insertAccessToken(accessToken);
    log.info('saveRefreshToken : $refreshToken');
    await insertRefreshToken(refreshToken);
  }

  Future deleteToken() async {
    await deleteRefreshToken();
    await deleteAccessToken();
  }
}
