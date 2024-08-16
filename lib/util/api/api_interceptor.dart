import 'package:calendar_app/repository/token_repository.dart';
import 'package:calendar_app/util/api/api.dart';
import 'package:calendar_app/util/log/logging_util.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor(this._api);

  final Logger log = LoggingUtil.logger('🚀API');
  final TokenRepository _tokenRepository = TokenRepository();
  final Dio _api;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? accessToken = await _tokenRepository.getAccessToken();

    if (accessToken != null) options.headers['access_token'] = accessToken;

    String prettyJson = '';

    try {
      prettyJson = LoggingUtil.getPrettyJson(options.data);
    } catch (e) {
      prettyJson = 'FILE';
    }

    log.info('\n[\x1B[34mREQUEST\x1B[0m]\n\n'
        'method : ${options.method}\n'
        'url : ${options.uri}\n\n'
        'headers : \n${LoggingUtil.getPrettyString(options.headers)}\n'
        'data : $prettyJson\n'
        'queryParams : ${options.queryParameters}\n\n'
        'extra : ${options.extra}\n\n');

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    var accessToken = await _tokenRepository.getAccessToken();
    var statusCode = err.response?.statusCode;
    log.info('[API ERROR] - statusCode : $statusCode, message : ${err.message}');
    if ((statusCode == 401 || statusCode == 403) && accessToken != null) {
      log.info('[API RETRY] - statusCode : $statusCode');
      return await retryApi(_api, err, handler);
    } else {
      return super.onError(err, handler);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // RESPONSE LOG
    log.info('\n[\x1B[31mRESPONSE\x1B[0m]\n\n'
        'url : ${response.realUri}\n\n'
        'headers :\n${response.headers}\n'
        'body : ${LoggingUtil.getPrettyJson(response.data)}\n\n');
    // RETURN
    return super.onResponse(response, handler);
  }
}
