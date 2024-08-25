import 'package:calendar_app/entity/jwt_token.dart';
import 'package:calendar_app/util/dataSource/remote/api.dart';
import 'package:calendar_app/util/dataSource/remote/response/api_response.dart';
import 'package:calendar_app/util/env/env.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class AuthRepository {
  AuthRepository._privateConstructor();

  factory AuthRepository() => _instance;
  static final AuthRepository _instance = AuthRepository._privateConstructor();

  final Logger _log = Logger('AuthRepository');

  final Dio _api = baseApi();

  Future<ApiResponse<JwtToken>> login(String username, String password) async {
    var response = await _api.post(
      Env.USER_LOGIN_API.value,
      data: {
        'username': username,
        'password': password,
      },
    );
    return ApiResultParser.toResponse(
      response.data,
      JwtToken.fromJson,
    );
  }

  Future<ApiResponse<Empty>> logout() async {
    var response = await _api.delete(
      Env.USER_LOGOUT_API.value,
    );
    return ApiResultParser.toEmptyResponse(
      response.data,
    );
  }

  Future<ApiResponse<JwtToken>> reIssueAccessToken(String refreshToken) async {
    var response =
        await _api.post(Env.USER_RE_ISSUE_ACCESS_TOKEN_API.value, data: {
      'refreshToken': refreshToken,
    });
    return ApiResultParser.toResponse(
      response.data,
      JwtToken.fromJson,
    );
  }
}
