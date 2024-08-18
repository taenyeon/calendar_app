sealed class ApiResult<T> {
  const ApiResult(this.resultCode, this.resultMessage);

  final String resultCode;
  final String resultMessage;
}

class SingleApiResult<T> extends ApiResult<T> {
  SingleApiResult(
    this.body, {
    required resultCode,
    required resultMessage,
  }) : super(resultCode, resultMessage);

  factory SingleApiResult.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) binding) {
    return SingleApiResult(
      binding(json['body']),
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
    );
  }

  T? body;
}

class ListApiResult<T> extends ApiResult<T> {
  ListApiResult(
    this.body, {
    required resultCode,
    required resultMessage,
  }) : super(resultCode, resultMessage);

  factory ListApiResult.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) binding) {
    List<T> list = (json['body'] as List).map((item) => binding(item)).toList();

    return ListApiResult(
      list,
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
    );
  }

  final List<T> body;
}
