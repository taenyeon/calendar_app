class ApiResponseList<T> {
  ApiResponseList({
    required this.resultCode,
    required this.resultMessage,
    this.body,
  });

  factory ApiResponseList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) binding,
  ) {
    return ApiResponseList(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      body: (json['body'] as List).map((item) => binding(item)).toList(),
    );
  }

  final String resultCode;
  final String resultMessage;
  final List<T>? body;
}
