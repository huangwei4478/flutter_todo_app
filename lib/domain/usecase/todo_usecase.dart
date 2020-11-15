import 'dart:async';

import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
import 'package:flutter_todo_app/core/result/result_ex.dart';
import 'package:flutter_todo_app/domain/model/category.dart';
import 'package:flutter_todo_app/domain/model/todo.dart';
import 'package:flutter_todo_app/domain/usecase/todo_usecase_interface.dart';
import 'package:flutter_todo_app/db/todo_gateway.dart';

class TodoUseCase extends TodoUseCaseInterface {
  final TodoGateway _todoGateway;

  TodoUseCase(this._todoGateway);

  @override
  Stream<Result<List<Category>>> fetchCategories() {
    return _todoGateway
        .fetchCategories()
        .asStream()
        .map((tables) =>
            tables.map((table) => Category.fromTable(table)).toList())
        .asyncMap(
      (categories) async {
        final newCategories = <Category>[];
        for (final category in categories) {
          final todos = await _todoGateway.fetchTodosOf(category.id);
          newCategories.add(category.copyWith(
              todos: todos.map((table) => Todo.fromTable(table)).toList()));
        }
        return newCategories;
      },
    ).toResult();
  }

  @override
  Stream<Result<Complete>> upsertCategories(List<Category> categories) {
    return _todoGateway
        .upsertCategories(
            categories.map((e) => e.toTable()).toList(growable: false))
        .toResultForComplete();
  }

  @override
  Stream<Result<Complete>> deleteCategories(List<Category> categories) {
    return _todoGateway
        .deleteCategories(
            categories.map((e) => e.toTable()).toList(growable: false))
        .toResultForComplete();
  }

  @override
  Stream<Result<List<Todo>>> fetchTodosOf(String categoryId) {
    return _todoGateway
        .fetchTodosOf(categoryId)
        .asStream()
        .map((tables) => tables.map((table) => Todo.fromTable(table)).toList())
        .toResult();
  }

  @override
  Stream<Result<Complete>> upsertTodos(List<Todo> todos) {
    return _todoGateway
        .upsertTodos(todos.map((e) => e.toTable()).toList(growable: false))
        .toResultForComplete();
  }

  @override
  Stream<Result<Complete>> deleteTodos(List<Todo> todos) {
    return _todoGateway
        .deleteTodos(todos.map((e) => e.toTable()).toList(growable: false))
        .toResultForComplete();
  }
}
