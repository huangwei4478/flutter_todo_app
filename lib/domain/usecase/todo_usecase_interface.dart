import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
import 'package:flutter_todo_app/domain/model/category.dart';
import 'package:flutter_todo_app/domain/model/todo.dart';

abstract class TodoUseCaseInterface {
  //region category operation methods
  Stream<Result<List<Category>>> fetchCategories();

  Stream<Result<Complete>> upsertCategories(List<Category> categories);

  Stream<Result<Complete>> deleteCategories(List<Category> categories);
  //endregion

  //region todos operation methods
  Stream<Result<List<Todo>>> fetchTodosOf(String categoryId);

  Stream<Result<Complete>> upsertTodos(List<Todo> todos);

  Stream<Result<Complete>> deleteTodos(List<Todo> todos);
  //endregion
}
