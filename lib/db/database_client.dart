import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_todo_app/db/table/category_table.dart';
import 'package:flutter_todo_app/db/table/todo_table.dart';
import 'package:flutter_todo_app/db/todo_gateway.dart';

class TodoClient {
  static const version = 1;
  static const databaseFileName = "todo_database.db";

  static Database _databaseStored;

  Future<Database> get _database async =>
      _databaseStored ??= await _openDataBase();

  Future<Database> _openDataBase() async {
    final path = join(await getDatabasesPath(), databaseFileName);
    return openDatabase(path, version: version,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }, onCreate: (Database db, int version) async {
      await CategoryTable.create(db, version);
      await TodoTable.create(db, version);
    });
  }

  Future<void> close() async => _databaseStored.close();

  Future<TodoGateway> getGateway() async {
    final database = await _database;
    return TodoGateway(database);
  }
}
