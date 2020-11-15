import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'base_view_model.dart';

class BasePage<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget child;
  final List<Provider> providers;

  BasePage({
    Key key,
    this.viewModel,
    this.child,
    List<Provider> providers,
  })  : providers = providers != null ? providers : [],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: viewModel),
        ...providers,
      ],
      child: child,
    );
  }
}
