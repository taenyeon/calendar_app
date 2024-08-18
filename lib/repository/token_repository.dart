import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

class TokenRepository {
  TokenRepository._privateConstructor();

  factory TokenRepository() => _instance;
  static final TokenRepository _instance = TokenRepository._privateConstructor();

  final Logger log = Logger('TokenRepository');

  final String _accessTokenKey = 'accessToken';
  final String _refreshTokenKey = 'refreshToken';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Default Function
  Future save(String key, String value) async {
    await drop(key);
    await _secureStorage.write(key: key, value: value);
  }

  Future drop(String tokenKey) async => await _secureStorage.delete(key: tokenKey);

  // AccessToken Function
  Future<String?> getAccessToken() async => await _secureStorage.read(key: _accessTokenKey);

  Future saveAccessToken(String value) async => await save(_accessTokenKey, value);

  Future dropAccessToken() async => await drop(_accessTokenKey);

  // RefreshToken Function
  Future<String?> getRefreshToken() async => await _secureStorage.read(key: _refreshTokenKey);

  Future saveRefreshToken(String value) async => await save(_refreshTokenKey, value);

  Future dropRefreshToken() async => await drop(_refreshTokenKey);

  // Tokens Function
  Future saveTokens(String accessToken, String refreshToken) async {
    log.info('saveAccessToken : $accessToken');
    await saveAccessToken(accessToken);
    log.info('saveRefreshToken : $refreshToken');
    await saveRefreshToken(refreshToken);
  }

  Future dropTokens() async {
    await dropRefreshToken();
    await dropAccessToken();
  }
}
