import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel {
  final CompositeSubscription compositeSubscription = CompositeSubscription();

  // think of 'dispose' like rxSwift
  void dispose() {
    compositeSubscription.clear();
  }
}
