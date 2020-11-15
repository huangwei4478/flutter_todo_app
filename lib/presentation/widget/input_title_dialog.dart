import 'package:flutter/material.dart';
import 'package:flutter_todo_app/presentation/pages/base/base_dialog.dart';

class InputTextDialog extends StatefulWidget {
  const InputTextDialog(
    this.hintText,
    this.defaultText,
  );

  final String hintText;
  final String defaultText;

  @override
  State createState() => _InputTextDialogState();
}

class _InputTextDialogState extends State<InputTextDialog> {
  final TextEditingController inputTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      content: TextField(
        controller: inputTextController,
        decoration: InputDecoration(
          hintText: widget?.hintText ?? '',
          border: InputBorder.none,
        ),
        autofocus: true,
        style: Theme.of(context).textTheme.headline6,
      ),
      onPressed: (action) {
        switch (action) {
          case DialogAction.ok:
            Navigator.pop<String>(context, inputTextController.text);
            break;
          case DialogAction.cancel:
            //Navigator.pop(context);
            break;
        }
      },
      needHiddenTitle: true,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.defaultText?.isNotEmpty ?? false) {
      inputTextController.value = TextEditingValue(text: widget.defaultText);
    }
  }

  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }
}

Future<String> showInputTextDialog({
  @required BuildContext context,
  @required String hintText,
  String defaultText,
  TransitionBuilder builder,
  bool useRootNavigator = true,
}) {
  final Widget dialog = InputTextDialog(hintText, defaultText);
  return showDialog(
    context: context,
    useRootNavigator: useRootNavigator,
    builder: (BuildContext context) {
      return builder == null ? dialog : builder(context, dialog);
    },
  );
}
