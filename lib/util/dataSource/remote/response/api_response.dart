class ApiResponse<T> {
  // ApiResultParser를 통해서만 접근해야함.
  ApiResponse._({
    required this.resultCode,
    required this.resultMessage,
    required this.body,
    bool? isLoading,
  });

  final String resultCode;
  final String resultMessage;
  final T body;
  bool isLoading = true;

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
      body: binding(json['body']),
      isLoading: false,
    );
  }

  static ApiResponse<Empty> toEmptyResponse(Map<String, dynamic> json) {
    return ApiResponse._(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      body: Empty._(),
      isLoading: false,
    );
  }

  static ApiResponse<List<T>> toListResponse<T>(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) binding,
  ) {
    return ApiResponse._(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      body: (json['body'] as List).map((e) => binding(e)).toList(),
      isLoading: false,
    );
  }

  static ApiResponse<Empty> loading<T>() {
    return ApiResponse._(
      resultCode: '',
      resultMessage: '',
      body: Empty._(),
    );
  }

  static ApiResponse<T> success<T>(T body) {
    return ApiResponse._(
      resultCode: 'SUCCESS',
      resultMessage: 'success',
      body: body,
      isLoading: false,
    );
  }

  static ApiResponse<Empty> empty() {
    return ApiResponse._(
      resultCode: 'SUCCESS',
      resultMessage: 'success',
      body: Empty._(),
      isLoading: false,
    );
  }

  static ApiResponse<T> fail<T>(T body) {
    return ApiResponse._(
      resultCode: 'FAIL',
      resultMessage: 'fail',
      body: body,
      isLoading: false,
    );
  }
}
