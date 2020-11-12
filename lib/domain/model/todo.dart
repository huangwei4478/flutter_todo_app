import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'todo_state.dart';

class Todo {
  final String id;
  final String categoryId;
  final String title;
  final TodoState state;
  final int position;

  Todo(
      {String id,
      @required this.categoryId,
      @required this.title,
      this.state = TodoState.InComplete,
      this.position = 0})
      : assert(categoryId != null),
        assert(title != null),
        id = id ?? Uuid().v4();
}
