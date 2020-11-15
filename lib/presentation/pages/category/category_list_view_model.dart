import 'package:flutter_todo_app/presentation/pages/base/base_view_model.dart';

import 'package:rxdart/rxdart.dart';
import 'package:flutter_todo_app/core/result/complete.dart';
import 'package:flutter_todo_app/core/result/result.dart';
//import 'package:flutter_todo_app/core/result/result_ex.dart';
import 'package:flutter_todo_app/domain/model/category.dart';
import 'package:flutter_todo_app/db/todo_gateway.dart';
import 'package:flutter_todo_app/presentation/pages/base/base_view_model.dart';

class CategoryViewModel extends BaseViewModel {
  final TodoGateway _todoGateWay;

  CategoryViewModel(this._todoGateWay);

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
    // _todoGateWay.fetchCategories().listen();
  }
}
