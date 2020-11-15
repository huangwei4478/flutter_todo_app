import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/domain/model/todo.dart';
import 'package:flutter_todo_app/db/table/category_table.dart';
import 'package:uuid/uuid.dart';

class Category {
  Category({
    String id,
    @required this.title,
    List<Todo> todos,
  })  : assert(title != null),
        id = id ?? Uuid().v4(),
        todos = todos ?? [];

  Category.fromTable(CategoryTable categoryTable)
      : id = categoryTable.id,
        title = categoryTable.title,
        todos = [];

  final String id;
  final String title;
  final List<Todo> todos;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ todos.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(Category, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          todos == other.todos;

  @override
  String toString() {
    return 'Category{id: $id, title: $title todos: $todos}';
  }

  CategoryTable toTable() {
    return CategoryTable(id: id, title: title);
  }

  Category copyWith({
    String id,
    String title,
    List<Todo> todos,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      todos: todos ?? this.todos,
    );
  }
}
