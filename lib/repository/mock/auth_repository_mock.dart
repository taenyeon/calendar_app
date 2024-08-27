import 'package:calendar_app/entity/jwt_token.dart';
import 'package:calendar_app/util/dataSource/remote/response/api_response.dart';
import 'package:logging/logging.dart';

class AuthRepositoryMock {
  AuthRepositoryMock._privateConstructor();

  factory AuthRepositoryMock() => _instance;
  static final AuthRepositoryMock _instance =
      AuthRepositoryMock._privateConstructor();

  final Logger _log = Logger('AuthRepository');

  Future<ApiResponse<JwtToken>> login(String username, String password) async {
    return ApiResultParser.success(
      JwtToken(
        accessToken: 'test',
        refreshToken: 'test',
      ),
    );
  }

  Future<ApiResponse<Empty>> logout() async {
    return ApiResultParser.empty();
  }

  Future<ApiResponse<JwtToken>> reIssueAccessToken(String refreshToken) async {
    return ApiResultParser.success(
      JwtToken(
        accessToken: 'test',
        refreshToken: 'test',
      ),
    );
  }
}
