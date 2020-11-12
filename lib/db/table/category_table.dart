import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'category_table.freezed.dart';
part 'category_table.g.dart';

@freezed
abstract class CategoryTable with _$CategoryTable {
  factory CategoryTable({
    @required final String id,
    @required final String title,
  }) = _CategoryTable;

  factory CategoryTable.fromJson(Map<String, dynamic> json) =>
      _$CategoryTableFromJson(json);

  static const tableName = 'category';
  static const columnId = 'id';
  static const columnTitle = 'title';

  static FutureOr<void> create(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $columnId TEXT PRIMARY KEY,
        $columnTitle TEXT
      )
    ''');
  }
}
