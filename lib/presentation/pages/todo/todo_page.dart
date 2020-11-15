import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
import 'package:flutter_todo_app/global/global.dart';
import 'package:flutter_todo_app/domain/model/todo.dart';
import 'package:flutter_todo_app/domain/model/todo_state.dart';
import 'package:flutter_todo_app/logger.dart';
import 'package:flutter_todo_app/presentation/pages/base/base_page.dart';
import 'package:flutter_todo_app/presentation/pages/todo/cell/cell.dart';
import 'package:flutter_todo_app/presentation/pages/todo/todo_page_argument.dart';
import 'package:flutter_todo_app/presentation/pages/todo/todo_view_model.dart';
import 'package:flutter_todo_app/presentation/res/dimens.dart';
import 'package:flutter_todo_app/presentation/widget/common_alert_dialog.dart';
import 'package:flutter_todo_app/presentation/widget/input_title_dialog.dart';
import 'package:flutter_todo_app/presentation/widget/toast.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({@required this.todoPageArgument});

  static String createTransitionTagOfTitle(String id) =>
      'transitionTagOfTitle$id}';

  static String createTransitionTagOfIndicator(String id) =>
      'transitionTagOfIndicator$id}';

  final TodoPageArgument todoPageArgument;

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final CompositeSubscription compositeSubscription = CompositeSubscription();
  final TodoViewModel viewModel = getIt.get<TodoViewModel>();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      viewModel: viewModel,
      child: const KeyboardVisibilityProvider(child: TodoPageContainer()),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel
      ..setup(widget.todoPageArgument)
      ..fetchTodos();
    _bindViewModelEvent();
  }

  @override
  void dispose() {
    viewModel.dispose();
    compositeSubscription.dispose();
    super.dispose();
  }

  void _bindViewModelEvent() {
    viewModel.eventOfUpdateCategory.listen((event) {
      logger.fine('eventOfUpdateCategory: $event');
      if (event is Failure<Complete>) {
        handleErrorOfUpdateCategory(event.e, context);
      }
    }).addTo(compositeSubscription);

    viewModel.eventOfDeleteCategory.listen((event) {
      logger.fine('eventOfDeleteCategory: $event');
      if (event is Failure<Complete>) {
        handleErrorOfDeleteCategory(event.e, context);
      }
    }).addTo(compositeSubscription);

    viewModel.eventOfFetchTodos.listen((event) {
      logger.fine('eventOfFetchTodos: $event');
      if (event is Failure<Complete>) {
        handleErrorOfFetchTodos(event.e, context);
      }
    }).addTo(compositeSubscription);

    viewModel.eventOfCreateTodo.listen((event) {
      logger.fine('eventOfCreateTodo: $event');
      if (event is Failure<Complete>) {
        handleErrorOfCreateTodo(event.e, context);
      }
    }).addTo(compositeSubscription);

    viewModel.eventOfDeleteTodo.listen((event) {
      logger.fine('eventOfDeleteTodo: $event');
      if (event is Failure<Complete>) {
        handleErrorOfDeleteTodo(event.e, context);
      }
    }).addTo(compositeSubscription);

    viewModel.eventOfUpdatingTodos.listen((event) {
      logger.fine('eventOfUpdatingTodos: $event');
      if (event is Failure<Complete>) {
        handleErrorOfUpdatingTodos(event.e, context);
      }
    }).addTo(compositeSubscription);
  }

  //region handle error methods
  void handleErrorOfUpdateCategory(Exception e, BuildContext context) {
    const message = 'update category error';
    showToast(message);
  }

  void handleErrorOfDeleteCategory(Exception e, BuildContext context) {
    const message = 'delete category error';
    showToast(message);
  }

  void handleErrorOfFetchTodos(Exception e, BuildContext context) {
    const message = 'fetch todo error';
    showToast(message);

    Navigator.pop(context);
  }

  void handleErrorOfCreateTodo(Exception e, BuildContext context) {
    const message = 'create todo error';
    showToast(message);
  }

  void handleErrorOfDeleteTodo(Exception e, BuildContext context) {
    const message = 'delete todo error';
    showToast(message);
  }

  void handleErrorOfUpdatingTodos(Exception e, BuildContext context) {
    const message = 'update todo error';
    showToast(message);
  }
}

class TodoPageContainer extends StatelessWidget {
  const TodoPageContainer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('add todos for...',
          style: TextStyle(fontSize: Dimens.fontSize16)),
      leading: IconButton(
        icon: const Icon(Icons.chevron_left_outlined),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            showCommonAlertDialog(
              context: context,
              title:
                  'delete ${context.read<TodoViewModel>().categoryTitleValue}?',
              actions: [
                DialogAction.cancel(),
                DialogAction.ok(
                  onPressed: () {
                    context
                        .read<TodoViewModel>()
                        .deleteCategory(() => Navigator.pop(context));
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      child: Stack(
        children: [
          Column(
            children: const [
              _HeaderContainer(),
              Expanded(child: _TodoListContainer()),
              SizedBox(height: _InputTextContainer.height),
            ],
          ),
          const _OverLayContainer(),
          const Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _InputTextContainer(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderContainer extends StatelessWidget {
  const _HeaderContainer();

  //region operation methods
  Future<void> _showConfirmOfUpdateCategoryDialog(
      BuildContext context, String categoryTitle) async {
    final title = await showInputTextDialog(
      context: context,
      hintText: 'category name',
      defaultText: categoryTitle,
    );
    context.read<TodoViewModel>().updateCategory(title);
  }

  //endregion

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _buildTitle(context),
      _buildIndicator(context),
      const Divider(),
    ]);
  }

  Widget _buildTitle(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimens.padding32,
          top: Dimens.padding16,
          right: Dimens.padding32),
      child: InkWell(
        onTap: () => _showConfirmOfUpdateCategoryDialog(
            context, viewModel.categoryTitleValue),
        child: Container(
          alignment: Alignment.centerLeft,
          child: StreamBuilder(
            initialData: viewModel.categoryTitleValue,
            stream: viewModel.categoryTitle,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Hero(
                tag: TodoPage.createTransitionTagOfTitle(
                    viewModel.transitionTagId),
                child: Text(
                  snapshot?.data ?? '',
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context);
    return Container(
      padding: const EdgeInsets.only(
        left: Dimens.padding32,
        top: Dimens.padding8,
        right: Dimens.padding32,
        bottom: Dimens.padding16,
      ),
      child: StreamBuilder(
        initialData: viewModel.todosValue,
        stream: viewModel.todos,
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          final todos = snapshot.data;
          return Hero(
            tag: TodoPage.createTransitionTagOfIndicator(
                viewModel.transitionTagId),
            child: LinearPercentIndicator(
              trailing: Text(
                '${todos.where((todo) => todo.state == TodoState.Completed).length}/${todos.length}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              padding: const EdgeInsets.only(
                  left: Dimens.padding4, right: Dimens.padding16),
              lineHeight: Dimens.viewSize4,
              progressColor: Theme.of(context).primaryColor,
              animateFromLastPercent: true,
              animation: true,
              percent: todos.isEmpty
                  ? 0
                  : todos
                          .where((todo) => todo.state == TodoState.Completed)
                          .length /
                      todos.length,
            ),
          );
        },
      ),
    );
  }
}

class _TodoListContainer extends StatelessWidget {
  const _TodoListContainer();

  //region operation methods
  void _checkTodo(TodoViewModel viewModel, Todo todo) {
    viewModel.checkTodo(todo.copyWith(state: todo.state.reverse()));
  }

  void _deleteTodo(TodoViewModel viewModel, Todo todo) {
    viewModel.deleteTodo(todo);
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TodoViewModel>(context, listen: false);

    return StreamBuilder(
      initialData: viewModel.todosValue,
      stream: viewModel.todos,
      builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
        final todos = snapshot.data;
        final todoItems = <BaseCell>[for (final todo in todos) TodoItem(todo)];

        // 前置处理：把已经完成的地方放一个CompleteSection
        final firstIndexOfCompleted =
            todos.indexWhere((e) => e.state == TodoState.Completed);
        if (firstIndexOfCompleted != -1) {
          todoItems.insert(firstIndexOfCompleted, const CompleteSection());
        }

        return ImplicitlyAnimatedReorderableList<BaseCell>(
          insertDuration: const Duration(milliseconds: 300),
          removeDuration: const Duration(milliseconds: 300),
          updateDuration: const Duration(milliseconds: 300),
          items: todoItems,
          areItemsTheSame: (oldItem, newItem) =>
              oldItem.identify == newItem.identify,
          onReorderFinished: (item, from, to, newItems) {
            // 观察索引
            final completedSectionIndex =
                newItems.indexWhere((e) => e is CompleteSection);
            var newState = TodoState.InComplete;
            if (completedSectionIndex != -1 && completedSectionIndex < to) {
              newState = TodoState.Completed;
            }
            // 从不同的类型中，抽出 TodoItem
            final newTodos = <Todo>[
              for (final todo
                  in newItems.whereType<TodoItem>().map((e) => e.todo))
                if (todo.id == item.identify)
                  todo.copyWith(state: newState)
                else
                  todo.copyWith()
            ];
            context.read<TodoViewModel>().reorderTodo(newTodos);
          },
          itemBuilder: (context, itemAnimation, todoItem, index) {
            if (todoItem is TodoItem) {
              return _buildTodoItem(context, itemAnimation, todoItem.todo);
            } else if (todoItem is CompleteSection) {
              return _buildCompleteSection(itemAnimation, todoItem);
            } else {
              // Oops
              throw Exception('unknown list item');
            }
          },
        );
      },
    );
  }

  Reorderable _buildCompleteSection(
      Animation<double> itemAnimation, BaseSection section) {
    return Reorderable(
      key: ValueKey(section),
      builder: (context, dragAnimation, inDrag) {
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: itemAnimation,
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.only(
              top: Dimens.padding8,
              bottom: Dimens.padding8,
              left: Dimens.padding32,
              right: Dimens.padding32,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(section.title),
            ),
          ),
        );
      },
    );
  }

  Reorderable _buildTodoItem(
      BuildContext context, Animation<double> itemAnimation, Todo todo) {
    final key = Key(todo.id.toString());

    return Reorderable(
      key: key,
      builder: (context, dragAnimation, inDrag) {
        final t = dragAnimation.value;
        final elevation = lerpDouble(0, 8, t);
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: itemAnimation,
          child: Material(
            type: MaterialType.button,
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: elevation,
            child: InkWell(
              onTap: () => _checkTodo(context.read<TodoViewModel>(), todo),
              child: Handle(
                delay: const Duration(milliseconds: 500),
                child: _buildTodoItemBody(context, itemAnimation, todo),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTodoItemBody(
      BuildContext context, Animation<double> itemAnimation, Todo todo) {
    final isCompleted = todo.state == TodoState.Completed;
    final titleTextTheme = isCompleted
        ? Theme.of(context).textTheme.subtitle1.copyWith(
            color: Theme.of(context).toggleableActiveColor,
            decoration: TextDecoration.lineThrough)
        : Theme.of(context).textTheme.subtitle1;
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimens.padding16, right: Dimens.padding16),
      child: SizedBox(
        height: Dimens.viewSize48,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: todo.state == TodoState.Completed,
              onChanged: null,
            ),
            Expanded(
              child: Text(
                '${todo.title}',
                style: titleTextTheme,
                overflow: TextOverflow.clip,
                maxLines: 1,
              ),
            ),
            Visibility(
              visible: isCompleted,
              child: ClipOval(
                child: Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: InkWell(
                    onTap: () =>
                        _deleteTodo(context.read<TodoViewModel>(), todo),
                    child: SizedBox(
                      height: Dimens.viewSize48,
                      width: Dimens.viewSize48,
                      child: Center(child: _buildClearIcon(context)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClearIcon(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.square(Dimens.viewSize20),
      child: ClipOval(
        child: Material(
          color: Theme.of(context).toggleableActiveColor,
          child: Ink(
            child: Icon(
              Icons.clear,
              color: Colors.white,
              size: Dimens.viewSize16,
            ),
          ),
        ),
      ),
    );
  }
}

class _OverLayContainer extends StatelessWidget {
  const _OverLayContainer();

  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    return Visibility(
      visible: isKeyboardVisible,
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
        ),
      ),
    );
  }
}

class _InputTextContainer extends StatefulWidget {
  const _InputTextContainer();

  static const height = Dimens.viewSize64;

  @override
  __InputTextContainerState createState() => __InputTextContainerState();
}

class __InputTextContainerState extends State<_InputTextContainer> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimens.radius16),
          topRight: Radius.circular(Dimens.radius16),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            offset: const Offset(0, -1),
          ),
        ],
      ),
      height: _InputTextContainer.height,
      padding: const EdgeInsets.only(
          left: Dimens.padding24, right: Dimens.padding24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'tap to add a todo thing',
                border: InputBorder.none,
              ),
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const SizedBox(
            width: Dimens.viewSize8,
          ),
          ClipOval(
            child: Material(
              child: Ink(
                child: IconButton(
                  iconSize: Dimens.viewSize24,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    context
                        .read<TodoViewModel>()
                        .createTodo(textController.text);
                    textController.value = const TextEditingValue(text: '');
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
