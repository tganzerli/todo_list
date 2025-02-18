import 'package:todo_list/core/config/injector.dart';

import 'pages/home/viewmodels/home_viewmodel.dart';
import 'pages/home/viewmodels/my_post_card_viewmodel.dart';
import 'start_viewmodel.dart';

void uiInjector() {
  injector.addSingleton<StartViewModel>(StartViewModel.new);
  injector.addSingleton<HomeViewModel>(HomeViewModel.new);
  injector.add<MyPostCardViewModel>(MyPostCardViewModel.new);
}
