import 'package:calendar_app/entity/jwt_token.dart';
import 'package:calendar_app/repository/auth_repository.dart';
import 'package:calendar_app/repository/token_repository.dart';
import 'package:calendar_app/util/dataSource/remote/response/api_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/provider/auth_provider.g.dart';

@riverpod
class AuthProvider extends _$AuthProvider {
  final TokenRepository _tokenRepository = TokenRepository();
  final AuthRepository _authRepository = AuthRepository();

  @override
  JwtToken build() {
    return JwtToken(
      accessToken: null,
      refreshToken: null,
    );
  }

  Future<void> init() async {
    state = await _tokenRepository.findToken();
  }

  Future<void> logout() async {
    ApiResponse<Empty> apiResponse = await _authRepository.logout();
    if (!apiResponse.isSuccess) throw Exception('');

    await _tokenRepository.deleteToken();

    state = JwtToken();
  }

  Future<void> login(String username, String password) async {
    ApiResponse<JwtToken> apiResponse = await _authRepository.login(
      username,
      password,
    );
    if (!apiResponse.isSuccess) throw Exception();

    JwtToken jwtToken = apiResponse.body;
    await _tokenRepository.insertToken(jwtToken);

    state = jwtToken;
  }

  Future<void> updateAccessToken() async {
    var refreshToken = await _tokenRepository.findRefreshToken();
    if (refreshToken == null) throw Exception();

    ApiResponse<JwtToken> apiResponse =
        await _authRepository.reIssueAccessToken(refreshToken);
    if (!apiResponse.isSuccess) throw Exception();

    JwtToken jwtToken = apiResponse.body;
    await _tokenRepository.insertAccessToken(jwtToken.accessToken!);

    state = state.copyWith(accessToken: jwtToken.accessToken);
  }
}
