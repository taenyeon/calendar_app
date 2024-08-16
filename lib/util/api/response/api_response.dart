import 'package:calendar_app/util/api/response/empty.dart';
import 'package:calendar_app/util/api/response/entity.dart';

class ApiResponse<T extends Entity> {
  ApiResponse({
    required this.resultCode,
    required this.resultMessage,
    this.body,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) binding,
  ) {
    if (T is Empty) {
      return ApiResponse(
        resultCode: json['resultCode'],
        resultMessage: json['resultMessage'],
      );
    }
    return ApiResponse(
      resultCode: json['resultCode'],
      resultMessage: json['resultMessage'],
      body: binding(json['body']),
    );
  }

  final String resultCode;
  final String resultMessage;
  final T? body;

  bool get isSuccess => resultCode == 'SUCCESS';
}
