import 'package:calendar_app/entity/jwt_token.dart';
import 'package:calendar_app/repository/auth_repository.dart';
import 'package:calendar_app/repository/token_repository.dart';
import 'package:calendar_app/util/dataSource/remote/response/api_response.dart';
import 'package:calendar_app/util/exception/error_exception.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../util/exception/error.dart';

part '../generated/provider/auth_provider.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  final TokenRepository _tokenRepository = TokenRepository();
  final AuthRepository _authRepository = AuthRepository();

  @override
  JwtToken build() {
    return JwtToken();
  }

  Future<void> init() async {
    state = await _tokenRepository.findToken();
  }

  Future<void> logout() async {
    ApiResponse<Empty> apiResponse = await _authRepository.logout();

    if (apiResponse.isFail) throw ErrorException(ErrorCase.alreadyLogout);

    await _tokenRepository.deleteToken();

    state = JwtToken();
  }

  Future<void> login(String username, String password) async {
    ApiResponse<JwtToken> apiResponse = await _authRepository.login(
      username,
      password,
    );

    if (apiResponse.isFail) throw ErrorException(ErrorCase.wrongPassword);

    JwtToken jwtToken = apiResponse.body;

    await _tokenRepository.insertToken(jwtToken);

    state = jwtToken;
  }

  Future<void> updateAccessToken() async {
    var refreshToken = await _tokenRepository.findRefreshToken();
    if (refreshToken == null) throw ErrorException(ErrorCase.notFound);

    ApiResponse<JwtToken> apiResponse =
        await _authRepository.reIssueAccessToken(refreshToken);

    if (apiResponse.isFail) throw ErrorException(ErrorCase.invalidToken);

    JwtToken jwtToken = apiResponse.body;
    await _tokenRepository.insertAccessToken(jwtToken.accessToken!);

    state = state.copyWith(accessToken: jwtToken.accessToken);
  }
}
