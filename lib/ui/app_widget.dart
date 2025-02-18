import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/start_viewmodel.dart';

import 'pages/add_post/add_post_page.dart';
import 'pages/calendar/calendar_page.dart';
import 'pages/home/home_page.dart';
import 'pages/info_post/info_post_page.dart';
import 'pages/splash/splash_page.dart';
import 'start_config_prod.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final StartViewModel viewModel = injector.get<StartViewModel>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(context),
      builder: StartConfig.instance,
      onGenerateRoute: (settings) {
        viewModel.routeEvent.execute(settings.name ?? '');
        final args = settings.arguments;
        switch (settings.name) {
          case '/home':
            return _customPageRoute(const HomePage(), transitionType: 'fade');
          case '/calendar':
            return _customPageRoute(const CalendarPage(),
                transitionType: 'fade');
          case '/addPost':
            return _customPageRoute(const AddPostPage());
          case '/infoPost':
            return _customPageRoute(InfoPostPage(
              post: args as PostsEntity,
            ));
          default:
            return _customPageRoute(const SplashPage(), transitionType: 'fade');
        }
      },
    );
  }
}

PageRouteBuilder _customPageRoute(Widget page,
    {String transitionType = 'slide'}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case 'fade':
          return FadeTransition(opacity: animation, child: child);
        case 'scale':
          return ScaleTransition(scale: animation, child: child);
        case 'slide':
        default:
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
              position: animation.drive(tween), child: child);
      }
    },
  );
}
