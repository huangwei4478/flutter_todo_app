import 'package:sqflite/sqflite.dart';
import 'package:flutter_todo_app/db/table/category_table.dart';
import 'package:flutter_todo_app/db/table/todo_table.dart';

class TodoGateway {
  final Database database;

  TodoGateway(this.database);

  ///region category operation methods

  Future<List<CategoryTable>> fetchCategories() async {
    return _fetchCategories(database);
  }

  Future<void> upsertCategories(List<CategoryTable> categories) async {
    await database.transaction((txn) async {
      final batch = txn.batch();
      for (final category in categories) {
        if (await _existsCategory(txn, category)) {
          await _updateCategory(txn, category);
        } else {
          await _createCategory(txn, category);
        }
      }
      await batch.commit();
    });
  }

  Future<void> deleteCategories(List<CategoryTable> categories) async {
    await database.transaction((txn) async {
      final batch = txn.batch();
      for (final category in categories) {
        await txn.delete(CategoryTable.tableName,
            where: '${CategoryTable.columnId} = ?',
            whereArgs: <String>[category.id]);
      }
      await batch.commit();
    });
  }

  Future<List<CategoryTable>> _fetchCategories(
      DatabaseExecutor executor) async {
    final rawCategoryTables = await executor.query(CategoryTable.tableName);
    return rawCategoryTables.map((raw) => CategoryTable.fromJson(raw)).toList();
  }

  Future<void> _createCategory(
      DatabaseExecutor executor, CategoryTable category) async {
    await executor.insert(CategoryTable.tableName, category.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _updateCategory(
      DatabaseExecutor executor, CategoryTable category) async {
    await executor.update(CategoryTable.tableName, category.toJson(),
        where: '${CategoryTable.columnId} = ?',
        whereArgs: <String>[category.id]);
  }

  Future<bool> _existsCategory(
      DatabaseExecutor executor, CategoryTable category) async {
    final categories = await executor.query(CategoryTable.tableName,
        where: '${CategoryTable.columnId} = ?',
        whereArgs: <String>[category.id]);
    return categories.isNotEmpty;
  }

  ///endregion

  ///region todos operation methods

  Future<List<TodoTable>> fetchTodosOf(String categoryId) async {
    return _fetchTodosOf(database, categoryId);
  }

  Future<void> upsertTodos(List<TodoTable> todos) async {
    await database.transaction((txn) async {
      final batch = txn.batch();

      for (final todo in todos) {
        if (await _existsTodo(txn, todo)) {
          await _updateTodo(txn, todo);
        } else {
          await _createTodo(txn, todo);
        }
      }
      await batch.commit();
    });
  }

  Future<void> deleteTodos(List<TodoTable> todos) async {
    await database.transaction((txn) async {
      final batch = txn.batch();
      for (final todo in todos) {
        await txn.delete(
          TodoTable.tableName,
          where:
              '${TodoTable.columnCategoryId} = ? and ${TodoTable.columnId} =  ?',
          whereArgs: <String>[todo.categoryId, todo.id],
        );
      }
      await batch.commit();
    });
  }

  Future<List<TodoTable>> _fetchTodosOf(
      DatabaseExecutor executor, String categoryId) async {
    final rawTodoTables = await executor.query(TodoTable.tableName,
        where: '${TodoTable.columnCategoryId} = ?',
        whereArgs: <String>[categoryId]);
    return rawTodoTables.map((raw) => TodoTable.fromJson(raw)).toList();
  }

  Future<void> _createTodo(DatabaseExecutor executor, TodoTable todo) async {
    await executor.insert(TodoTable.tableName, todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _updateTodo(DatabaseExecutor executor, TodoTable todo) async {
    await executor.update(TodoTable.tableName, todo.toJson(),
        where:
            '${TodoTable.columnCategoryId} = ? and ${TodoTable.columnId} = ?',
        whereArgs: <String>[todo.categoryId, todo.id]);
  }

  Future<bool> _existsTodo(DatabaseExecutor executor, TodoTable todo) async {
    final todos = await executor.query(TodoTable.tableName,
        where: '${TodoTable.columnId} = ?', whereArgs: <String>[todo.id]);
    return todos.isNotEmpty;
  }

  ///endregion
}
