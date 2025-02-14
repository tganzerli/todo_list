import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/core/core.dart';

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
  final client = injector.get<RestClient>();

  Future<void> addInterceptors() async {}

  @override
  void initState() {
    super.initState();
    addInterceptors();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? Container();
  }
}
