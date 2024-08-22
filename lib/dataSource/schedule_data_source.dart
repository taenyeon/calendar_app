import 'package:calendar_app/entity/schedule.dart';
import 'package:calendar_app/util/dataSource/local_data_source.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ScheduleDataSource {
  ScheduleDataSource._();

  factory ScheduleDataSource() => _instance;
  static final ScheduleDataSource _instance = ScheduleDataSource._();

  final LocalDataSource localDataSource = LocalDataSource();
  final String table = 'schedule';

  Future<Database> get _database async => await localDataSource.database;

  Future<bool> insert(Schedule schedule) async {
    Database database = await _database;
    int resultCount = await database.insert(
      table,
      schedule.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return resultCount > 0;
  }

  Future<bool> update(int id, Schedule schedule) async {
    Database database = await _database;
    int resultCount = await database
        .update(table, schedule.toJson(), where: 'id = ?', whereArgs: [id]);
    return resultCount > 0;
  }

  Future<bool> delete(int id) async {
    Database database = await _database;
    int resultCount =
        await database.delete(table, where: 'id = ?', whereArgs: [id]);
    return resultCount > 0;
  }

  Future<List<Schedule>> findAll() async {
    Database database = await _database;
    List<Map<String, Object?>> list = await database.query(table);
    return list.map((e) => Schedule.fromJson(e)).toList();
  }

  Future<Schedule?> findById(int id) async {
    Database database = await _database;
    return _firstOrNull(
        await database.query(table, where: 'id = ?', whereArgs: [id]));
  }

  Future<Schedule?> findByMonth(int month) async {
    Database database = await _database;
    return _firstOrNull(
        await database.query(table, where: 'month = ?', whereArgs: [month]));
  }

  Future<Schedule?> findByYear(int year) async {
    Database database = await _database;
    return _firstOrNull(
        await database.query(table, where: 'year = ?', whereArgs: [year]));
  }

  Schedule? _firstOrNull(List<Map<String, Object?>> list) {
    Map<String, Object?>? firstOrNull = list.firstOrNull;
    if (firstOrNull == null) return null;
    return Schedule.fromJson(firstOrNull);
  }
}
