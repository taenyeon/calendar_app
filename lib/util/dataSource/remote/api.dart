import 'package:calendar_app/repository/token_repository.dart';
import 'package:calendar_app/util/dataSource/remote/api_interceptor.dart';
import 'package:calendar_app/util/dataSource/remote/retry_api_interceptor.dart';
import 'package:calendar_app/util/env/env.dart';
import 'package:dio/dio.dart';

Dio baseApi({bool hasSecure = false}) {
  Dio api = Dio();
  // options
  api.options.baseUrl = Env.BASE_API_PATH.value;

  api.interceptors.clear();
  api.interceptors.add(ApiInterceptor(api));
  return api;
}

Future<void> retryApi(
  Dio errorApi,
  DioException error,
  ErrorInterceptorHandler handler,
) async {
  Dio api = Dio();

  TokenRepository tokenRepository = TokenRepository();

  String? refreshToken = await tokenRepository.findRefreshToken();
  if (refreshToken == null) return handler.next(error);

  api.options.baseUrl = Env.BASE_API_PATH.value;

  api.interceptors.clear();
  api.interceptors.add(RetryApiInterceptor());

  Response response = await api.post(
    Env.USER_RE_ISSUE_ACCESS_TOKEN_API.value,
    data: {'refreshToken': refreshToken},
  );

  String? newAccessToken = response.data['body']['accessToken'] as String?;

  if (newAccessToken == null) return handler.next(error);

  await tokenRepository.insertAccessToken(newAccessToken);
  await errorApi.request(
    error.requestOptions.path,
    options: Options(
      method: error.requestOptions.method,
      headers: error.requestOptions.headers,
    ),
    data: error.requestOptions.data,
    queryParameters: error.requestOptions.queryParameters,
  );
  return handler.resolve(response);
}
