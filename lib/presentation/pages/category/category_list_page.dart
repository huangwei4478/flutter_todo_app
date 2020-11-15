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
import 'package:flutter_todo_app/presentation/res/dimens.dart';
import 'package:flutter_todo_app/presentation/widget/toast.dart';

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

  void _bindViewModelEvent() {}

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
    return Container();
  }
}
