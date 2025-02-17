import 'package:flutter/material.dart';
import 'package:todo_list/domain/entities/user_logged_entity.dart';

class HomePage extends StatefulWidget {
  final UserLoggedEntity userLoggedEntity;
  const HomePage({super.key, required this.userLoggedEntity});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
