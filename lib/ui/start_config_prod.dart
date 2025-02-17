import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/ui/start_viewmodel.dart';

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
      Navigator.popAndPushNamed(context, '/home',
          arguments: viewModel.userLogged);
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.authEvent.execute();
    viewModel.authEvent.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}
