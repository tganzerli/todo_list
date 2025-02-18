import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
