import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/ui/app_routes.dart';
import 'package:todo_list/ui/start_viewmodel.dart';

import 'app_widget.dart';

class StartConfig extends StatefulWidget {
  final Widget? child;

  const StartConfig({super.key, this.child});

  static StartConfig instance(BuildContext context, Widget? child) {
    return StartConfig(child: child);
  }

  @override
  State<StartConfig> createState() => _StartConfigState();
}

class _StartConfigState extends State<StartConfig> {
  final StartViewModel viewModel = injector.get<StartViewModel>();

  void listener() {
    if (viewModel.authEvent.isSuccess) {
      Future.microtask(() {
        navigatorKey.currentState?.popAndPushNamed(AppRoutes.home);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.cleanCacheEvent.execute();
    viewModel.authEvent.execute();
    viewModel.authEvent.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}
