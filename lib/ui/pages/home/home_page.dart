import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/widget/app_bar/app_bar.dart';
import 'package:todo_list/ui/widget/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'viewmodels/home_viewmodel.dart';
import 'viewmodels/home_viewmodel_state.dart';
import 'widget/header.dart';
import 'widget/in_progress_posts.dart';
import 'widget/my_post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel viewModel = injector.get<HomeViewModel>();

  void listener() {
    HomeViewmodelState state = viewModel.state;
    if (state is HomeSuccess) {}
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
  void dispose() {
    viewModel.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    return Scaffold(
      appBar: AppBarWidget(),
      bottomNavigationBar: BottomNavigation(),
      body: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, state, _) {
          final userNextsPosts = viewModel.userNextsPosts();
          final inProgressPosts = viewModel.inProgressPosts();
          if (state is HomeLoading || state is HomeInitial) {
            return Container();
          }

          if (state.posts.isEmpty) {
            return Container();
          }

          return NestedScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                      child: SizedBox(height: spacing.marginApp)),
                  SliverToBoxAdapter(
                    child: InProgressPosts(
                      posts: inProgressPosts,
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: HeaderMyPosts(),
                    pinned: true,
                  ),
                ];
              },
              body: ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: spacing.marginApp),
                itemCount: userNextsPosts.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: spacing.spacingXS,
                ),
                itemBuilder: (context, index) {
                  return MyPostCard(
                    post: userNextsPosts[index],
                  );
                },
              ));
        },
      ),
    );
  }
}
