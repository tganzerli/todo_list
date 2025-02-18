import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/widget/bottom_navigation_bar/bottom_navigation_bar.dart';

import 'viewmodels/calendar_viewmodel.dart';
import 'viewmodels/calendar_viewmodel_state.dart';
import 'widget/header_filter.dart';
import 'widget/post_card.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final CalendarViewModel viewModel = injector.get<CalendarViewModel>();

  void listener() {
    CalendarViewmodelState state = viewModel.state;

    if (state is CalendarError) {
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
    final spacing = AppSpacing.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      bottomNavigationBar: BottomNavigation(),
      body: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, state, _) {
          if (state is CalendarLoading || state is CalendarInitial) {
            return Container();
          }

          if (state.posts.isEmpty) {
            return Container();
          }
          return ListenableBuilder(
              listenable: viewModel.filterEvent,
              builder: (context, _) {
                final list = viewModel.filterEvent.rightResult ?? state.posts;

                return NestedScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverPersistentHeader(
                        delegate: HeaderFilter(
                          status: viewModel.filterEvent.result == null
                              ? PostsStatusEnum.values
                              : viewModel.filterEvent.param,
                          onSelected: (status) =>
                              viewModel.filterEvent.execute(status),
                        ),
                        pinned: true,
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.only(top: spacing.spacingSM),
                    child: ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: spacing.marginApp),
                      itemCount: list.length,
                      separatorBuilder: (context, index) => SizedBox(
                        height: spacing.spacingXS,
                      ),
                      itemBuilder: (context, index) {
                        return PostCard(
                          post: list[index],
                        );
                      },
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
