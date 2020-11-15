// dependencies injection

import 'package:flutter_todo_app/presentation/pages/todo/todo_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_todo_app/domain/usecase/todo_usecase.dart';
import 'package:flutter_todo_app/db/database_client.dart';
import 'package:flutter_todo_app/db/todo_gateway.dart';
import 'package:flutter_todo_app/presentation/pages/category/category_list_view_model.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGlobal() async {
  await _setupGlobalForInfra();
  _setupGlobalForViewModel();
}

Future<void> _setupGlobalForInfra() async {
  final todoGateWay = await TodoClient().getGateway();
  getIt
    ..registerSingleton<TodoGateway>(todoGateWay)
    ..registerFactory<TodoUseCase>(() => TodoUseCase(getIt.get<TodoGateway>()));
}

void _setupGlobalForViewModel() {
  getIt
    ..registerFactory(() => CategoryViewModel(getIt.get<TodoUseCase>()))
    ..registerFactory(() => TodoViewModel(getIt.get<TodoUseCase>()));
}
