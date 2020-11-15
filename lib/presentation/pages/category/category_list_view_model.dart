import 'package:flutter_todo_app/presentation/pages/base/base_view_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
import 'package:flutter_todo_app/core/result/result_ex.dart';
import 'package:flutter_todo_app/domain/model/category.dart';
import 'package:flutter_todo_app/domain/usecase/todo_usecase.dart';
import 'package:flutter_todo_app/presentation/pages/base/base_view_model.dart';

class CategoryViewModel extends BaseViewModel {
  final TodoUseCase _todoUseCase;

  CategoryViewModel(this._todoUseCase);

  //region event of result
  final _eventOfFetchCategorySubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfFetchCategory =>
      _eventOfFetchCategorySubject.stream;

  final _eventOfCreateCategorySubject = PublishSubject<Result<Category>>();

  Stream<Result<Category>> get eventOfCreateCategory =>
      _eventOfCreateCategorySubject.stream;

  final _eventOfDeleteCategorySubject = PublishSubject<Result<Complete>>();

  Stream<Result<Complete>> get eventOfDeleteCategory =>
      _eventOfDeleteCategorySubject.stream;
  //endregion

  //region notify value
  final BehaviorSubject<List<Category>> categoriesSubject =
      BehaviorSubject<List<Category>>.seeded([]);

  Stream<List<Category>> get categories => categoriesSubject.stream;

  List<Category> get categoriesValue => categoriesSubject.value;
  //endregion

  @override
  void dispose() {
    _eventOfFetchCategorySubject.close();
    _eventOfCreateCategorySubject.close();
    _eventOfDeleteCategorySubject.close();
    super.dispose();
  }

  void fetchCategories() {
    _todoUseCase.fetchCategories().listen((event) {
      _eventOfFetchCategorySubject.add(event.toComplete());
      if (event is Success<List<Category>>) {
        categoriesSubject.add(event.value);
      }
    }).addTo(compositeSubscription);
  }

  void createCategory(String title) {
    if (title.isEmpty) {
      return;
    }

    final newCategory = Category(title: title);
    final newCategories = [
      for (final category in categoriesValue) category.copyWith(),
      newCategory
    ];

    _todoUseCase.upsertCategories([newCategory]).listen((event) {
      _eventOfCreateCategorySubject.add(event.mapTo((event) => newCategory));
      if (event is Success) {
        categoriesSubject.add(newCategories);
      }
    }).addTo(compositeSubscription);
  }

  void deleteCategory(Category category) {
    final newCategories = [
      for (final category
          in categoriesValue.where((element) => element.id != category.id))
        category.copyWith(),
    ];

    _todoUseCase.deleteCategories([category]).listen((event) {
      _eventOfDeleteCategorySubject.add(event);
      if (event is Success) {
        categoriesSubject.add(newCategories);
      }
    }).addTo(compositeSubscription);
  }
}
