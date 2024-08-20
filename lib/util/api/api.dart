import 'package:calendar_app/repository/token_repository.dart';
import 'package:calendar_app/util/api/api_interceptor.dart';
import 'package:calendar_app/util/api/response/api_response.dart';
import 'package:calendar_app/util/api/retry_api_interceptor.dart';
import 'package:calendar_app/util/entity/example_entity.dart';
import 'package:dio/dio.dart';

Future<ApiResponse<ExampleEntity>> apiExample<T>() async {
  Response response = await api().get('/example');
  // ApiResponse.fromJson(response.data);
  return ApiResultParser.toResponse<ExampleEntity>(
      response.data, ExampleEntity.fromJson);
}

Dio api({bool hasSecure = false}) {
  Dio api = Dio();

  // options
  api.options.baseUrl = 'http://127.0.0.1:8001/api';

  api.interceptors.clear();
  api.interceptors.add(ApiInterceptor(api));
  return api;
}

Future<void> retryApi(
    Dio errorApi, DioException error, ErrorInterceptorHandler handler) async {
  Dio api = Dio();

  TokenRepository tokenRepository = TokenRepository();

  String? refreshToken = await tokenRepository.getRefreshToken();
  if (refreshToken == null) return handler.next(error);

  api.options.baseUrl = 'http://127.0.0.1/api';

  api.interceptors.clear();
  api.interceptors.add(RetryApiInterceptor());

  Response response = await api.post(
    '/user/accessToken',
    data: {'refreshToken': refreshToken},
  );

  String? newAccessToken = response.data['body']['accessToken'] as String?;

  if (newAccessToken == null) return handler.next(error);

  await tokenRepository.saveAccessToken(newAccessToken);
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
