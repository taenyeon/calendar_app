import 'package:calendar_app/util/api/response/api_result.dart';
import 'package:calendar_app/util/entity/example_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test('test', () {
    var value = 'foo,bar,baz';
    expect(value.split(','), equals(['foo', 'bar', 'baz']));
  });

  test('parse_datetime', () {
    DateTime datetime = DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/1 00:00:00');
    expect(datetime.weekday, equals(4));
    int month = datetime.month + 1;
    List<Map<String, dynamic>> dates = [];
    while (datetime.month < month) {
      dates.add({
        'year': datetime.year,
        'month': datetime.month,
        'day': datetime.day,
        'hour': datetime.hour,
        'minute': datetime.minute,
        'second': datetime.second,
        'weekday': datetime.weekday
      });
      datetime = datetime.add(const Duration(days: 1));
    }
    for (Map<String, dynamic> date in dates) {
      print('$date\n');
    }
  });

  test('find_between_datetimes', () {
    DateTime startDateTime = DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/14 07:00:00');
    DateTime endDateTime = DateFormat('yyyy/MM/dd HH:mm:ss').parse('2024/08/16 15:00:00');

    DateTime dateTime = startDateTime.copyWith();
    List<Map<String, dynamic>> dates = [];
    while (dateTime.isBefore(endDateTime)) {
      Map<String, dynamic> calendar;
      if (dateTime.difference(endDateTime).inDays == 0) {
        calendar = {
          'startDateTime': endDateTime.copyWith(hour: 00, minute: 00, second: 00),
          'endDateTime': endDateTime,
        };
      } else if (dateTime.difference(startDateTime).inDays == 0) {
        calendar = {
          'startDateTime': startDateTime,
          'endDateTime': startDateTime.copyWith(hour: 23, minute: 59, second: 59),
        };
      } else {
        calendar = {
          'startDateTime': dateTime.copyWith(hour: 0, minute: 0, second: 0),
          'endDateTime': dateTime.copyWith(hour: 23, minute: 59, second: 59),
        };
      }
      dates.add(calendar);
      dateTime = dateTime.add(const Duration(days: 1));
    }
    for (Map<String, dynamic> date in dates) {
      print('$date\n');
    }
  });

  test('entity_test', () {
    Map<String, dynamic> json = {
      'resultCode': 'Success',
      'resultMessage': 'success',
      'body': {
        'a': 'test',
        'b': 'test',
      }
    };
    SingleApiResult<ExampleEntity> singleResult = SingleApiResult.fromJson(json, ExampleEntity.fromJson);
    print(singleResult.body);
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
    ListApiResult<ExampleEntity> listApiResult =
        ListApiResult.fromJson(json, ExampleEntity.fromJson);
    print(listApiResult.body);
  });
}
