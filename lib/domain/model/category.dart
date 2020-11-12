import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'todo.dart';

class Category {
  final String id;
  final String title;
  final List<Todo> todos;

  Category({String id, @required this.title, List<Todo> todos})
      : assert(title != null),
        id = id ?? Uuid().v4(),
        todos = todos ?? [];
}
