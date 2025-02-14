import 'package:flutter/material.dart';

import 'start_config_prod.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: StartConfig.instance,
      routes: {},
    );
  }
}
