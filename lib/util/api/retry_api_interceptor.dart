import 'package:calendar_app/repository/token_repository.dart';
import 'package:calendar_app/util/log/logging_util.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class RetryApiInterceptor extends Interceptor {
  final Logger log = LoggingUtil.logger('🚀API RETRY');
  final TokenRepository _tokenRepository = TokenRepository();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    log.info('\n[\x1B[34mREQUEST\x1B[0m]\n\n'
        'method : ${options.method}\n'
        'url : ${options.uri}\n\n'
        'headers : \n${LoggingUtil.getPrettyString(options.headers)}\n'
        'data : ${LoggingUtil.getPrettyJson(options.data)}\n'
        'queryParams : ${options.queryParameters}\n\n'
        'extra : ${options.extra}\n\n');
    return super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    int? errorCode = err.response?.statusCode;
    if (errorCode == 401 || errorCode == 403) {
      await _tokenRepository.dropTokens();
    }
    return super.onError(err, handler);
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
