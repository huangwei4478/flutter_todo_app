import 'package:flutter_todo_app/domain/model/category.dart';

class TodoPageArgument {
  TodoPageArgument(this.category, this.transitionTagId);

  final Category category;
  final String transitionTagId;
}
