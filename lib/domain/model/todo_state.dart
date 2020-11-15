enum TodoState { InComplete, Completed }

extension StateEx on TodoState {
  //region for table methods
  static TodoState fromTable(int stateValue) {
    switch (stateValue) {
      case 0:
        return TodoState.InComplete;
      case 1:
        return TodoState.Completed;
      default:
        throw Exception('need to add switch case');
    }
  }

  int toTable() {
    switch (this) {
      case TodoState.InComplete:
        return 0;
      case TodoState.Completed:
        return 1;
      default:
        throw Exception('need to add switch case');
    }
  }

  //endregion
  TodoState reverse() {
    switch (this) {
      case TodoState.InComplete:
        return TodoState.Completed;
      case TodoState.Completed:
        return TodoState.InComplete;
      default:
        throw Exception('need to add switch case');
    }
  }

  TodoState copy() {
    switch (this) {
      case TodoState.InComplete:
        return TodoState.InComplete;
      case TodoState.Completed:
        return TodoState.Completed;
      default:
        throw Exception('need to add switch case');
    }
  }
}
