import 'package:rxdart/rxdart.dart';
import 'result.dart';

import 'complete.dart';

extension ResultEx<T> on Result<T> {
  Result<S> mapTo<S>(S Function(T event) convert) {
    return map(
        success: (value) => Result.success(convert(value.value)),
        failure: (value) => Result.failure(value.e),
        loading: (_) => const Result.loading());
  }

  Result<Complete> toComplete() {
    return map<Result<Complete>>(
        success: (value) => Result.success(Complete()),
        failure: (value) => Result.failure(value.e),
        loading: (_) => const Result.loading());
  }
}

extension WrapStreamByResult<T> on Stream<T> {
  Stream<Result<T>> toResult() {
    return map((value) => Result.success(value))
        .onErrorReturnWith(
            (dynamic error) => Result.failure(error as Exception))
        .startWith(const Result.loading());
  }
}

extension WrapFutreByResult<T> on Future<T> {
  Stream<Result<T>> toResult() {
    return asStream().toResult();
  }

  // fixme
  // figure it out
  Stream<Result<Complete>> toResultForComplete() {
    return asStream()
        .map((value) => Result.success(Complete()))
        .onErrorReturnWith(
            (dynamic error) => Result.failure(error as Exception))
        .startWith(const Result.loading());
  }
}
