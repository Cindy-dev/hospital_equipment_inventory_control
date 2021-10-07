import 'package:hospital_dbms/database/models/equipment.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelpers {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'equipment.db'),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE hospital_equipment(
           id TEXT PRIMARY KEY, 
           name TEXT,
           quantity TEXT,  
           image TEXT,
           dest TEXT,
           presentQuantity Text)''');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    print(data);
    final db = await DBHelpers.database();
    var rawData = db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    print(rawData);
  }

  static Future<void> delete(String id) async {
    final db = await DBHelpers.database();
    db.delete("hospital_equipment", where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelpers.database();
    return db.query(table);
  }

  static Future<int> update(Equipment equipment) async {
    final db = await DBHelpers.database();
    return await db.update("hospital_equipment", equipment.toMap(),
        where: "id = ?", whereArgs: [equipment.id]);
  }
}
