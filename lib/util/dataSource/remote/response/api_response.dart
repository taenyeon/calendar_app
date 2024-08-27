class ApiResponse<T> {
  // ApiResultParser를 통해서만 접근해야함.
  ApiResponse._({
    required this.resultCode,
    required this.resultMessage,
    required this.body,
  });

  final String resultCode;
  final String resultMessage;
  final T body;

  bool get isSuccess => resultCode == 'SUCCESS';
  bool get isFail => resultCode != 'SUCCESS';
}

class Empty {
  Empty._();

  factory Empty._uninstantiable() {
    throw UnsupportedError('class Null cannot be instantiated');
  }

  Map<String, dynamic> toJson() {
    throw UnsupportedError('Empty unsupported toJson');
  }

  @override
  String toString() {
    return 'Empty';
  }
}

class ApiResultParser {
  ApiResultParser();

  static ApiResponse<T> toResponse<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) binding,
  ) {
    return ApiResponse._(
        resultCode: json['resultCode'],
        resultMessage: json['resultMessage'],
        body: binding(json['body']));
  }

  static ApiResponse<Empty> toEmptyResponse(Map<String, dynamic> json) {
    return ApiResponse._(
        resultCode: json['resultCode'],
        resultMessage: json['resultMessage'],
        body: Empty._());
  }

  static ApiResponse<List<T>> toListResponse<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) binding,
  ) {
    return ApiResponse._(
        resultCode: json['resultCode'],
        resultMessage: json['resultMessage'],
        body: (json['body'] as List).map((e) => binding(e)).toList());
  }

  static ApiResponse<T> success<T>(T body) {
    return ApiResponse._(
      resultCode: 'SUCCESS',
      resultMessage: 'success',
      body: body,
    );
  }

  static ApiResponse<Empty> empty() {
    return ApiResponse._(
      resultCode: 'SUCCESS',
      resultMessage: 'success',
      body: Empty._(),
    );
  }

  static ApiResponse<Empty> fail() {
    return ApiResponse._(
      resultCode: 'FAIL',
      resultMessage: 'fail',
      body: Empty._(),
    );
  }
}
