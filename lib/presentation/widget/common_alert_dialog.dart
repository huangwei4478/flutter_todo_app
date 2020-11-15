import 'package:flutter/material.dart';
import 'package:flutter_todo_app/presentation/navigator/app_navigator.dart';
import 'package:flutter_todo_app/presentation/res/dimens.dart';

enum DialogActionType {
  ok,
  cancel,
}

class DialogAction {
  DialogAction.ok({this.onPressed}) : type = DialogActionType.ok;

  DialogAction.cancel({this.onPressed}) : type = DialogActionType.cancel;

  final DialogActionType type;
  final Function onPressed;

  String get title {
    switch (type) {
      case DialogActionType.ok:
        return 'OK';
      case DialogActionType.cancel:
        return 'CANCEL';
      default:
        throw Exception('unknown DialogActionType');
    }
  }
}

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog(
    this.title,
    this.message,
    this.actions, {
    this.needHiddenTitle = false,
  });

  final String title;
  final String message;
  final bool needHiddenTitle;
  final List<DialogAction> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius16),
        ),
      ),
      title: _buildTitle(),
      content: Visibility(
        visible: message != null,
        child: Text(message ?? ''),
      ),
      actions: [for (final action in actions) _buildButton(context, action)],
    );
  }

  Widget _buildTitle() {
    return Visibility(
      visible: !needHiddenTitle,
      child: Padding(
        padding: const EdgeInsets.only(bottom: Dimens.padding8),
        child: Text(
          title,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, DialogAction action) {
    return FlatButton(
      child: Text(
        action.title,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onPressed: () {
        action.onPressed?.call();
        AppNavigator.pop(context);
      },
    );
  }
}

Future<void> showCommonAlertDialog({
  @required BuildContext context,
  @required String title,
  String message,
  List<DialogAction> actions,
  TransitionBuilder builder,
  bool useRootNavigator = true,
}) {
  final Widget dialog = CommonAlertDialog(title, message, actions);
  return showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}

Future<void> showOkAlertDialog({
  @required BuildContext context,
  @required String title,
  String message,
  TransitionBuilder builder,
  bool useRootNavigator = true,
}) {
  final Widget dialog = CommonAlertDialog(title, message, [DialogAction.ok()]);
  return showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}
