import 'package:flutter/material.dart';
import 'package:flutter_todo_app/presentation/res/dimens.dart';

enum DialogAction {
  ok,
  cancel,
}

class BaseDialog extends StatelessWidget {
  final String title;
  final bool needHiddenTitle;
  final Function(DialogAction action) onPressed;
  final Widget content;

  const BaseDialog({
    Key key,
    this.title = '',
    this.needHiddenTitle = false,
    @required this.onPressed,
    @required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Dimens.radius16),
        ),
      ),
      title: _buildTitle(),
      content: content,
      actions: _buildButtons(context),
    );
  }

  Widget _buildTitle() {
    return Visibility(
        visible: !needHiddenTitle,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(title),
        ));
  }

  List<Widget> _buildButtons(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    return [
      TextButton(
          onPressed: onPressed(DialogAction.cancel),
          child: Text(
            localizations.cancelButtonLabel,
            style: Theme.of(context).textTheme.subtitle1,
          )),
      TextButton(
        child: Text(
          localizations.okButtonLabel,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        onPressed: () {
          onPressed(DialogAction.ok);
        },
      ),
    ];
  }
}
