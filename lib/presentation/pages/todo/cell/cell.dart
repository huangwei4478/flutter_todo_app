import 'package:flutter_todo_app/domain/model/todo.dart';

/// hierarchy
/// - base cell
///   - base section
///   - base item

/// base item
abstract class BaseCell {
  const BaseCell();

  String get identify;

  BaseCell copy();
}

//region item
/// base item
abstract class BaseItem extends BaseCell {}

class TodoItem extends BaseItem {
  TodoItem(this.todo);

  final Todo todo;

  @override
  String get identify {
    return todo.id;
  }

  @override
  BaseCell copy() {
    return TodoItem(todo.copyWith());
  }
}
//endregion

//region section
/// base section
abstract class BaseSection extends BaseCell {
  const BaseSection();

  String get title;
}

class CompleteSection extends BaseSection {
  const CompleteSection();

  @override
  String get identify {
    return 'finished';
  }

  @override
  String get title {
    return 'finished';
  }

  @override
  BaseCell copy() {
    return this;
  }
}
//endregion
