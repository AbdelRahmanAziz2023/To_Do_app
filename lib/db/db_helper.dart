import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? db;
  static const int version = 1;
  static const String tableName = 'tasks';

  static Future<void> initDb() async {
    if (db != null) {
      print('null db');
      return;
    } else {

      try {
        String path = '${await getDatabasesPath()}task.db';
        db = await openDatabase(path, version: version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $tableName ('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'title STRING,note TEXT,color INTEGER,'
              'date STRING,startTime STRING,endTime STRING,'
              'repeat STRING,isCompleted INTEGER,remind INTEGER)'
          );
        });
        print('db init');
      } catch (e) {
        print(e);
        print('error');
      }
    }
  }
  static Future<int> insert(Task? task)async{
    print('task insert');
    return await db!.insert(tableName,task!.toJson());
  }
  static Future<int> delete(Task task)async{
    print('task delete');
    return await db!.delete(tableName,where: 'id=?',whereArgs: [task.id]);
  }
  static Future<int> upDate(Task task)async{
    print('task mark');
    return await db!.rawUpdate('''
    UPDATE $tableName
    SET isCompleted = ?
    WHERE id = ?
    ''',[1,task.id]);
  }
  static Future<List<Map<String, Object?>>> query()async{
    print('task load');
    return await db!.query(tableName);
  }

}
