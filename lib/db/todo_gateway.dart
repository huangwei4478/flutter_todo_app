import 'package:sqflite/sqflite.dart';
import 'package:flutter_todo_app/db/table/category_table.dart';
import 'package:flutter_todo_app/db/table/todo_table.dart';

class TodoGateway {
  final Database database;

  TodoGateway(this.database);

  ///region category operation methods

  Future<List<CategoryTable>> _fetchCategories(
      DatabaseExecutor executor) async {}

  Future<void> _createCategory(
      DatabaseExecutor executor, CategoryTable category) async {
    ///TODO
  }

  Future<void> _updateCategory(
      DatabaseExecutor executor, CategoryTable category) async {
    ///TODO
  }

  Future<bool> _existsCategory(
      DatabaseExecutor executor, CategoryTable category) async {
    ///TODO
  }

  ///endregion

  ///region todos operation methods

  Future<List<TodoTable>> _fetchTodosOf(
      DatabaseExecutor executor, String categoryId) async {}

  Future<void> _createTodo(DatabaseExecutor executor, TodoTable todo) async {}

  Future<void> _updateTodo(DatabaseExecutor executor, TodoTable todo) async {}

  Future<bool> _existsTodo(DatabaseExecutor executor, TodoTable todo) async {}

  ///endregion
}
