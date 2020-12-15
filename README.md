# flutter_todo_app
a todo app that can track your daily routine, implemented by flutter

# how it implements

    - MVVM + RxDart + simplified version of Clean Architecture;
    - support data persistency on both iOS and android platforms;
    - use Provider as a dependency injection method, to provide viewModel on any layer of the widget tree
    - tailored color scheme, look so cool!

```dart
getIt.registerSingleton<AppModel>(AppModelImplementation());        // setup singleton
getIt.registerLazySingleton<RESTAPI>(() =>RestAPIImplementation()); // setup singleton for RestAPI
context.read<CategoryViewModel>().createCategory(title)             // get viewModel anywhere you want providing a context object
```

# how to run
```cmd
flutter run
```

or 

```cmd
flutter build apk --target-platform android-arm64 --split-per-abi
```

to export 64-bit arm android apk

![screenshot01.png](https://i.loli.net/2020/12/15/AcmwNiBVtJG6v9e.jpg)
![screenshot02.png](https://i.loli.net/2020/12/15/OEgZG2HYMjWIdxC.jpg)
