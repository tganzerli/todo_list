import 'package:auto_injector/auto_injector.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/data/data.dart';
import 'package:todo_list/ui/ui.dart';

final injector = AutoInjector();

void setupDependencies() {
  coreInjector();
  dataInjector();
  uiInjector();
  injector.commit();
}
