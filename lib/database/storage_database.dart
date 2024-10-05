import 'package:animevn/database/storage_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageDatabase {
  static const DB_NAME = 'storage.db';
  static const DB_VERSION = 1;
  static Database? _database;

  StorageDatabase._internal();

  static final StorageDatabase instance = StorageDatabase._internal();

  Future<Database?> get database async {
    if (_database == null) {
      await init();
    }
    return _database;
  }

  static const initScripts = [StorageTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [];

  Future<void> init() async {
    _database = await openDatabase(join(await getDatabasesPath(), DB_NAME),
        onCreate: (db, version) async {
      for (var script in initScripts) {
        await db.execute(script);
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      for (var script in migrationScripts) {
        await db.execute(script);
      }
    },version: DB_VERSION);
  }
}
