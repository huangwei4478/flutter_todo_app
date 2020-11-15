import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_todo_app/db/table/todo_table.dart';
import 'todo_state.dart';

class Todo {
  Todo({
    String id,
    @required this.categoryId,
    @required this.title,
    this.state = TodoState.InComplete,
    this.position = 0,
  })  : assert(categoryId != null),
        assert(title != null),
        id = id ?? Uuid().v4();

  Todo.fromTable(TodoTable todoTable)
      : id = todoTable.id,
        categoryId = todoTable.categoryId,
        title = todoTable.title,
        state = StateEx.fromTable(todoTable.state),
        position = todoTable.position;

  final String id;
  final String categoryId;
  final String title;
  final TodoState state;
  final int position;

  @override
  int get hashCode =>
      id.hashCode ^ categoryId.hashCode ^ title.hashCode ^ state.hashCode ^ position.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          categoryId == other.categoryId &&
          title == other.title &&
          state == other.state &&
          position == other.position;

  @override
  String toString() {
    return 'Todo{id: $id, categoryId: $categoryId, title: $title, state: $state, position: $position}';
  }

  TodoTable toTable() {
    return TodoTable(
      id: id,
      categoryId: categoryId,
      title: title,
      state: state.toTable(),
      position: position,
    );
  }

  Todo copyWith({
    String id,
    String categoryId,
    String title,
    TodoState state,
    int position,
  }) {
    return Todo(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      state: state ?? this.state.copy(),
      position: position ?? this.position,
    );
  }
}
