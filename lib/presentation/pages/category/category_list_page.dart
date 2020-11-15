import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_todo_app/presentation/widget/input_title_dialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
import 'package:flutter_todo_app/global/global.dart';
import 'package:flutter_todo_app/domain/model/category.dart';
import 'package:flutter_todo_app/domain/model/todo.dart';
import 'package:flutter_todo_app/domain/model/todo_state.dart';
import 'package:flutter_todo_app/logger.dart';
import 'package:flutter_todo_app/presentation/navigator/app_navigator.dart';
import 'package:flutter_todo_app/presentation/pages/base/base_page.dart';
import 'package:flutter_todo_app/presentation/pages/category/category_list_view_model.dart';
import 'package:flutter_todo_app/presentation/pages/todo/todo_page_argument.dart';
import 'package:flutter_todo_app/presentation/res/dimens.dart';
import 'package:flutter_todo_app/presentation/widget/toast.dart';
import 'package:flutter_todo_app/presentation/widget/common_alert_dialog.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage();

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  final CompositeSubscription compositeSubscription = CompositeSubscription();
  final CategoryViewModel viewModel = getIt.get<CategoryViewModel>();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      viewModel: viewModel,
      child: _CategoryPageContainer(),
    );
  }

  @override
  void initState() {
    super.initState();
    viewModel.fetchCategories();
    _bindViewModelEvent();
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _bindViewModelEvent() {
    viewModel.eventOfFetchCategory.listen((event) {
      logger.fine('eventOfFetchCategory: $event');
      if (event is Failure<Complete>) {
        handleErrorOfFetchCategory(event.e);
      }
    }).addTo(compositeSubscription);

    viewModel.eventOfCreateCategory.listen((event) {
      logger.fine('eventOfCreateCategory: $event');
      event.maybeWhen(
        success: (category) async => _pushToTodoPage(category),
        failure: handleErrorOfCreateCategory,
        orElse: () {},
      );
    }).addTo(compositeSubscription);

    viewModel.eventOfDeleteCategory.listen((event) {
      logger.fine('eventOfDeleteCategory: $event');
      if (event is Failure<Complete>) {
        handleErrorOfDeleteCategory(event.e);
      }
    }).addTo(compositeSubscription);
  }

  Future<void> _pushToTodoPage(Category category) async {
    await AppNavigator.pushTodoPage(
        context, TodoPageArgument(category, category.id));
    viewModel.fetchCategories();
  }

  //region handler error methods
  void handleErrorOfFetchCategory(Exception e) {
    const message = 'failed to fetch category';
    showToast(message);
  }

  void handleErrorOfCreateCategory(Exception e) {
    const message = 'failed to create category';
    showToast(message);
  }

  void handleErrorOfDeleteCategory(Exception e) {
    const message = 'failed to delete category';
    showToast(message);
  }
  //endregion
}

class _CategoryPageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: const SafeArea(child: _CategoryList()),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      child: SizedBox(
        height: Dimens.viewSize48,
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final title = await showInputTextDialog(
            context: context, hintText: 'your todo here');
        if (title != null) {
          context.read<CategoryViewModel>().createCategory(title);
        }
      },
      child: Icon(Icons.add_comment),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);
    return StreamBuilder(
      initialData: viewModel.categoriesValue,
      stream: viewModel.categories,
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        final categories = snapshot.data ?? [];
        return ScrollConfiguration(
            behavior: const ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: StaggeredGridView.countBuilder(
                padding: const EdgeInsets.symmetric(
                    vertical: Dimens.padding16, horizontal: Dimens.padding8),
                crossAxisCount: 2,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) =>
                    CategoryListItem(categories[index]),
                staggeredTileBuilder: (int index) =>
                    const StaggeredTile.fit(1)));
      },
    );
  }
}

class CategoryListItem extends StatelessWidget {
  final Category category;

  const CategoryListItem(this.category);

  /// todo maximum display count
  static const maxDisplayTodosCount = 8;

  /// use category.id as a transitionId for the use of Hero
  String get transitionId => category.id;

  //region operation methods
  Future<void> _pushToTodoPage(BuildContext context) async {
    await AppNavigator.pushTodoPage(
        context, TodoPageArgument(category, transitionId));
    context.read<CategoryViewModel>().fetchCategories();
  }

  void _showConfirmOfDeletingCategoryDialog(BuildContext context) {
    showCommonAlertDialog(
      context: context,
      title: 'want to delete [${category.title}]?',
      actions: [
        DialogAction.cancel(),
        DialogAction.ok(
          onPressed: () {
            context.read<CategoryViewModel>().deleteCategory(category);
          },
        ),
      ],
    );
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    final todos = category.todos;
    todos
      ..sort((a, b) => a.position.compareTo(b.position))
      ..sort((a, b) => (a.state.toTable()).compareTo(b.state.toTable()));
    final displayTodos = [
      if (todos.length > maxDisplayTodosCount)
        ...todos.getRange(0, maxDisplayTodosCount)
      else
        ...todos
    ];

    return Card(
      child: InkWell(
          onTap: () => _pushToTodoPage(context),
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.all(Dimens.padding16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(context, todos, displayTodos),
                  _buildIndicator(context, todos, displayTodos),
                  _buildTodoItems(context, todos, displayTodos),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildTitle(
      BuildContext context, List<Todo> todos, List<Todo> displayTodos) {
    return SizedBox(
      height: Dimens.viewSize32,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              category?.title ?? '',
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          if (displayTodos.isNotEmpty &&
              displayTodos
                      .where((todo) => todo.state == TodoState.Completed)
                      .length ==
                  displayTodos.length)
            GestureDetector(
              onTap: () => showToast('TODO delete category'),
              child: Container(
                padding: const EdgeInsets.all(Dimens.padding8),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(Dimens.radius16),
                ),
                child: Text(
                  'Done',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      .copyWith(fontSize: 10, color: Colors.blueGrey[50]),
                ),
              ),
            )
          else
            Text(
              '${todos.where((todo) => todo.state == TodoState.Completed).length}/${todos.length}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
        ],
      ),
    );
  }

  Widget _buildIndicator(
      BuildContext context, List<Todo> todos, List<Todo> displayTodos) {
    return Visibility(
      visible: displayTodos.isNotEmpty,
      child: Container(
        height: Dimens.viewSize16,
        child: LinearPercentIndicator(
          padding: const EdgeInsets.only(top: Dimens.padding8),
          lineHeight: Dimens.viewSize4,
          progressColor: Theme.of(context).primaryColor,
          percent: displayTodos.isEmpty
              ? 0
              : todos
                      .where((todo) => todo.state == TodoState.Completed)
                      .length /
                  todos.length,
        ),
      ),
    );
  }

  Widget _buildTodoItems(
      BuildContext context, List<Todo> todos, List<Todo> displayTodos) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.padding16),
      child: Column(
        children: [
          for (final todo in displayTodos) _buildTodoItem(context, todo),
          Visibility(
            visible: todos.length > maxDisplayTodosCount,
            child: Container(
              padding: const EdgeInsets.only(
                left: Dimens.padding4,
                top: Dimens.padding8,
                right: Dimens.padding4,
              ),
              alignment: Alignment.centerLeft,
              height: Dimens.viewSize24,
              child: Text(
                '+ ${todos.length - maxDisplayTodosCount} Tasks',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.grey[400]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoItem(BuildContext context, Todo todo) {
    final isCompleted = todo.state == TodoState.Completed;
    final titleTextTheme = isCompleted
        ? Theme.of(context).textTheme.subtitle2.copyWith(
            color: Theme.of(context).toggleableActiveColor,
            decoration: TextDecoration.lineThrough)
        : Theme.of(context).textTheme.subtitle2;

    return SizedBox(
      height: Dimens.viewSize24,
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox.fromSize(
            size: Size.square(Dimens.viewSize20),
            child: Transform.scale(
              scale: 0.8,
              child: Checkbox(
                value: todo.state == TodoState.Completed,
                onChanged: null,
              ),
            ),
          ),
          const SizedBox(width: Dimens.padding8),
          Expanded(
            child: Text(
              '${todo.title}',
              style: titleTextTheme,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
