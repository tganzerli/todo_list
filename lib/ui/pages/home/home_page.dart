import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/ui/widget/app_bar/app_bar.dart';
import 'package:todo_list/ui/widget/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/home_viewmodel_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel viewModel = injector.get<HomeViewModel>();

  void listener() {
    HomeViewmodelState state = viewModel.state;
    if (state is HomeSuccess) {
      print(state.posts.length);
    }
    if (state is HomeError) {
      print(state.message);
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.addListener(listener);
    viewModel.initEvent.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
