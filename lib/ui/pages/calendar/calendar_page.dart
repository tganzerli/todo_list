import 'package:flutter/material.dart';
import 'package:todo_list/ui/widget/app_bar/app_bar.dart';
import 'package:todo_list/ui/widget/bottom_navigation_bar/bottom_navigation_bar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
