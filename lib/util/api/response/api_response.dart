class ApiResponse<T> {
  ApiResponse({
    required this.resultCode,
    required this.resultMessage,
    this.body,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>)? binding,
  ) {
    return ApiResponse(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      body: binding!(json['body']),
    );
  }

  final String resultCode;
  final String resultMessage;
  final T? body;

  bool get isSuccess => resultCode == 'SUCCESS';
}
