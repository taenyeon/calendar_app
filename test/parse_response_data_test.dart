import 'package:calendar_app/util/api/response/api_response.dart';
import 'package:calendar_app/util/entity/example_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('entity_test', () {
    Map<String, dynamic> json = {
      'resultCode': 'Success',
      'resultMessage': 'success',
      'body': {
        'a': 'test',
        'b': 'test',
      }
    };
    ApiResponse<ExampleEntity> apiResponse =
        ApiResultParser.toResponse(json, ExampleEntity.fromJson);

    print(apiResponse.body);
  });

  test('entity_list_test', () {
    Map<String, dynamic> json = {
      'resultCode': 'Success',
      'resultMessage': 'success',
      'body': [
        {
          'a': 'test1',
          'b': 'test1',
        },
        {
          'a': 'test2',
          'b': 'test2',
        }
      ]
    };
    ApiResponse<List<ExampleEntity>> apiResponse =
        ApiResultParser.toListResponse(json, ExampleEntity.fromJson);

    print(apiResponse.body);
    expect(apiResponse.body.length, equals(2));
  });

  test(
      'empty_entity_test',
      () => () {
            Map<String, dynamic> json = {
              'resultCode': 'Success',
              'resultMessage': 'success',
            };
            ApiResponse<Empty> response = ApiResultParser.toEmptyResponse(json);
            print(response.body);
          });
}
