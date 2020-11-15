enum AppRoutes { categoryList, todo }

extension AppRoutesEx on AppRoutes {
  String get name {
    switch (this) {
      case AppRoutes.categoryList:
        return '/category/list';
      case AppRoutes.todo:
        return '/todo';
      default:
        throw Exception('unknown AppRoutes');
    }
  }
}
