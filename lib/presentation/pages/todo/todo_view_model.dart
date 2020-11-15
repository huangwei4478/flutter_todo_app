import 'package:rxdart/rxdart.dart';
import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
import 'package:flutter_todo_app/core/result/result_ex.dart';
import 'package:flutter_todo_app/domain/model/category.dart';
import 'package:flutter_todo_app/domain/model/todo.dart';
import 'package:flutter_todo_app/domain/model/todo_state.dart';
import 'package:flutter_todo_app/domain/usecase/todo_usecase.dart';
import 'package:flutter_todo_app/logger.dart';
import 'package:flutter_todo_app/presentation/pages/base/base_view_model.dart';
import 'package:flutter_todo_app/presentation/pages/todo/todo_page_argument.dart';

class TodoViewModel extends BaseViewModel {
  final TodoUseCase _todoUseCase;

  TodoViewModel(this._todoUseCase);

  //region argument
  TodoPageArgument todoPageArgument;

  Category get category => todoPageArgument?.category;

  String get transitionTagId => todoPageArgument?.transitionTagId;

  //endregion

  //region event of result
  final _eventOfUpdateCategorySubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfUpdateCategory =>
      _eventOfUpdateCategorySubject.stream;

  final _eventOfDeleteCategorySubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfDeleteCategory =>
      _eventOfDeleteCategorySubject.stream;

  final _eventOfFetchTodosSubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfFetchTodos =>
      _eventOfFetchTodosSubject.stream;

  final _eventOfCreateTodoSubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfCreateTodo =>
      _eventOfCreateTodoSubject.stream;

  final _eventOfDeleteTodoSubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfDeleteTodo =>
      _eventOfDeleteTodoSubject.stream;

  final _eventOfUpdatingTodosSubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfUpdatingTodos =>
      _eventOfUpdatingTodosSubject.stream;

  //endregion

  //region notify value
  final _categoryTitleSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get categoryTitle => _categoryTitleSubject.stream;

  String get categoryTitleValue => _categoryTitleSubject.value;

  final _todosSubject = BehaviorSubject<List<Todo>>.seeded([]);

  Stream<List<Todo>> get todos => _todosSubject.stream;

  List<Todo> get todosValue => _todosSubject.value;

  //endregion

  @override
  void dispose() {
    _eventOfUpdateCategorySubject.close();
    _eventOfDeleteCategorySubject.close();
    _eventOfFetchTodosSubject.close();
    _eventOfCreateTodoSubject.close();
    _eventOfDeleteTodoSubject.close();
    _eventOfUpdatingTodosSubject.close();
    _categoryTitleSubject.close();
    _todosSubject.close();
    super.dispose();
  }

  //region categories operation methods
  void updateCategory(String title) {
    if (title == null || title.isEmpty) {
      return;
    }

    final newCategory = todoPageArgument.category.copyWith(title: title);

    _todoUseCase.upsertCategories([newCategory]).listen(
      (event) {
        _eventOfUpdateCategorySubject.add(event.toComplete());
        if (event is Success) {
          _categoryTitleSubject.add(newCategory.title);
        }
      },
    ).addTo(compositeSubscription);
  }

  void deleteCategory(Function onDeleted) {
    _todoUseCase.deleteCategories([todoPageArgument.category]).listen(
      (event) {
        _eventOfDeleteCategorySubject.add(event);
        if (event is Success) {
          onDeleted();
        }
      },
    ).addTo(compositeSubscription);
  }

  //endregion

  void setup(TodoPageArgument argument) {
    todoPageArgument = argument;
    _categoryTitleSubject.add(argument.category.title);
  }

  //region todos operation methods
  void fetchTodos() {
    _todoUseCase.fetchTodosOf(category.id).listen(
      (event) {
        _eventOfFetchTodosSubject.add(event.toComplete());
        if (event is Success<List<Todo>>) {
          _notifyTodos(event.value);
        }
      },
    ).addTo(compositeSubscription);
  }

  void createTodo(String title) {
    if (title == null || title.isEmpty) {
      return;
    }
    final newTodo = Todo(categoryId: category.id, title: title);
    final newTodos = _copyAndSaveTodoPosition([newTodo, ...todosValue]);

    _todoUseCase.upsertTodos(newTodos).listen(
      (event) {
        _eventOfCreateTodoSubject.add(event.toComplete());
        if (event is Success) {
          _notifyTodos(newTodos);
        }
      },
    ).addTo(compositeSubscription);
  }

  void deleteTodo(Todo todo) {
    logger.fine('deleteTodo $todo');
    final newTodos = _copyAndSaveTodoPosition(
        todosValue.where((e) => e.id != todo.id).toList());

    _todoUseCase.deleteTodos([todo]).listen(
      (event) {
        _eventOfDeleteTodoSubject.add(event);
        if (event is Success) {
          _notifyTodos(newTodos);
        }
      },
    ).addTo(compositeSubscription);
  }

  void checkTodo(Todo targetTodo) {
    logger.fine('checkTodo');
    final newTodos = _copyAndSaveTodoPosition(
      [
        for (final todo in todosValue)
          if (todo.id == targetTodo.id) targetTodo else todo
      ],
    );

    _todoUseCase.upsertTodos([targetTodo]).listen(
      (event) {
        _eventOfUpdatingTodosSubject.add(event.toComplete());
        if (event is Success) {
          _notifyTodos(newTodos);
        }
      },
    ).addTo(compositeSubscription);
  }

  void reorderTodo(List<Todo> todos) {
    logger.fine('reorderTodo');
    final newTodos = _copyAndSaveTodoPosition(todos);

    _notifyTodos(newTodos);

    _todoUseCase
        .upsertTodos(newTodos)
        .listen((event) => _eventOfUpdatingTodosSubject.add(event.toComplete()))
        .addTo(compositeSubscription);
  }

  void _notifyTodos(List<Todo> todos) {
    todos
      ..sort((a, b) => a.position.compareTo(b.position))
      ..sort((a, b) => convertTodoStateToValue(a.state)
          .compareTo(convertTodoStateToValue(b.state)));
    _todosSubject.add(List<Todo>.from(todos));
  }
  //endregion

  //region util methods
  List<Todo> _copyAndSaveTodoPosition(List<Todo> todos) {
    return [
      for (final map in todos.asMap().entries)
        map.value.copyWith(position: map.key)
    ];
  }

  int convertTodoStateToValue(TodoState state) {
    switch (state) {
      case TodoState.InComplete:
        return 0;
      case TodoState.Completed:
        return 1;
      default:
        throw Exception('need to add switch case');
    }
  }
//endregion
}
