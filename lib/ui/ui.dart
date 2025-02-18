import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/ui/pages/add_post/viewmodels/date_field_viewmodel.dart';

import 'pages/add_post/viewmodels/add_post_viewmodel.dart';
import 'pages/add_post/viewmodels/body_text_field_viewmodel.dart';
import 'pages/add_post/viewmodels/title_text_field_viewmodel.dart';
import 'pages/calendar/viewmodels/calendar_viewmodel.dart';
import 'pages/home/viewmodels/home_viewmodel.dart';
import 'pages/home/viewmodels/my_post_card_viewmodel.dart';
import 'start_viewmodel.dart';

void uiInjector() {
  injector.addSingleton<StartViewModel>(StartViewModel.new);
  injector.addSingleton<HomeViewModel>(HomeViewModel.new);
  injector.add<CalendarViewModel>(CalendarViewModel.new);
  injector.add<AddPostViewModel>(AddPostViewModel.new);
  injector.add<MyPostCardViewModel>(MyPostCardViewModel.new);
  injector.add<TitleTextFieldViewmodel>(TitleTextFieldViewmodel.new);
  injector.add<BodyTextFieldViewmodel>(BodyTextFieldViewmodel.new);
  injector.add<DateFieldViewmodel>(DateFieldViewmodel.new);
}
