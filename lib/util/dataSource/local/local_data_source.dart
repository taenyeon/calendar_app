import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  LocalDataSource._();

  factory LocalDataSource() => _instance;
  static final LocalDataSource _instance = LocalDataSource._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _init();
    return _database!;
  }

  Future<Database> _init() async {
    String path = join(await getDatabasesPath(), 'calendar.db');
    return await openDatabase(
      path,
      version: 1,
      // onCreate: (db, version) async {
      //   await db.execute('SELECT 1');
      // }
    );
  }
}
