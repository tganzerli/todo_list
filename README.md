# Todo List

This To-Do List app is built using the latest architectural guidelines introduced by the Flutter team, ensuring a seamless, intuitive, and highly scalable experience.

This documentation covers the project's structure, design patterns, and how modern Flutter architecture principles have been implemented to create a modular, testable, and maintainable codebase. 

## 📌 Technology

The technology chosen for the development of this project was `Flutter`. Find out more at: [flutter.dev](https://flutter.dev/)


### Required Versions
- **Dart**: [![Dart][dart_img]][dart_ln] [Official Dart Documentation](https://dart.dev)

- **Flutter**: [![Flutter][flutter_img]][flutter_ln] [Official Flutter Documentation](https://docs.flutter.dev/get-started/install)

### Main Packages Used

- [Auto Injector](https://pub.dev/packages/auto_injector): Dependency injection in the app


## 💡 Usage
To start the project, use the following command:

```sh
flutter run -t lib/main.dart 
```

## 🧪 Running Tests

To ensure the functionality of the exception classes, run the unit tests using:

```sh
flutter test 
```

### **Running tests with coverage**
To generate a coverage report:

```sh
flutter test --coverage
```

To view coverage results in an HTML report:
```sh
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html  # macOS
xdg-open coverage/html/index.html  # Linux
start coverage/html/index.html  # Windows
```

## 📖 **Documentation**
....


---

<!-- Links úteis: -->
[dart_img]: https://img.shields.io/static/v1?label=Dart&message=3.6.1&color=blue&logo=dart
[dart_ln]: https://dart.dev/ "https://dart.dev/"
[flutter_img]: https://img.shields.io/static/v1?label=Flutter&message=3.27.3&color=blue&logo=flutter
[flutter_ln]: https://docs.flutter.dev/get-started/install "https://docs.flutter.dev/get-started/install"
