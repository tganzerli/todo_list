import 'package:auto_injector/auto_injector.dart';
import 'package:todo_list/core/core.dart';

final injector = AutoInjector();

void setupDependencies() {
  injector.addInjector(coreInjector);
  injector.commit();
}
