import 'package:flutter/material.dart';
import 'package:flutter_todo_app/presentation/navigator/app_routers.dart';
import 'package:flutter_todo_app/presentation/pages/category/category_list_page.dart';

class AppNavigator {
  static Widget getHome() => const CategoryListPage();

  static Future<void> pushCategoryListPage(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CategoryListPage(),
        settings: RouteSettings(name: AppRoutes.categoryList.name),
      ),
    );
  }

  static Future<void> pushTodoPage(BuildContext context) async {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const Text("TODO"),
        settings: RouteSettings(name: AppRoutes.todo.name),
      ),
    );
  }

  static void pop(BuildContext context) {
    _unFocus(context);
    Navigator.pop(context);
  }

  static void _unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
