import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'category_table.dart';

part 'todo_table.freezed.dart';
part 'todo_table.g.dart';

@freezed
abstract class TodoTable with _$TodoTable {
  factory TodoTable({
    @required final String id,
    @required final String categoryId,
    @required final String title,
    @required final int state,
    @required final int position,
  }) = _TodoTable;

  factory TodoTable.fromJson(Map<String, dynamic> json) =>
      _$TodoTableFromJson(json);

  static const tableName = 'todo';
  static const columnId = 'id';
  static const columnCategoryId = 'categoryId';
  static const columnTitle = 'title';
  static const columnState = 'state';
  static const columnPosition = 'position';

  static FutureOr<void> create(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $tableName (
          $columnId TEXT PRIMARY KEY,
          $columnCategoryId TEXT,
          $columnTitle TEXT,
          $columnState INTEGER,
          $columnPosition INTEGER,
          FOREIGN KEY ($columnCategoryId) REFERENCES ${CategoryTable.tableName} (${CategoryTable.columnId}) ON DELETE CASCADE ON UPDATE CASCADE
        )''');
  }
}
