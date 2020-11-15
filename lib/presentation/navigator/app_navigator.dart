import 'package:flutter/material.dart';
import 'package:flutter_todo_app/presentation/navigator/app_routers.dart';

class AppNavigator {
  static Widget getHome(BuildContext context) => Text('TODO');

  static Widget pushTodoPage(BuildContext context) => Text('TODO');

  static void pop(BuildContext context) {}

  static void _unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
