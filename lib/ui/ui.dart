import 'package:todo_list/core/config/injector.dart';

import 'start_viewmodel.dart';

void uiInjector() {
  injector.addSingleton<StartViewModel>(StartViewModel.new);
}
