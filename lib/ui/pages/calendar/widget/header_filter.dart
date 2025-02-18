import 'package:flutter/material.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/layout/layout.dart';

class HeaderFilter extends SliverPersistentHeaderDelegate {
  final List<PostsStatusEnum> status;
  final void Function(List<PostsStatusEnum> status)? onSelected;
  const HeaderFilter({required this.status, this.onSelected});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colors = AppColors.of(context);
    final spacing = AppSpacing.of(context);
    return Container(
        alignment: Alignment.center,
        color: colors.scaffoldBackground,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
              horizontal: spacing.marginApp, vertical: spacing.spacingXS),
          itemCount: PostsStatusEnum.values.length + 1,
          separatorBuilder: (context, index) => SizedBox(
            width: spacing.spacingXS,
          ),
          itemBuilder: (context, index) {
            if (index == 0) {
              return ChoiceChip(
                label: Text(
                  'Todos',
                ),
                onSelected: (value) {
                  if (onSelected != null) {
                    onSelected!(PostsStatusEnum.values);
                  }
                },
                selected: status.length == PostsStatusEnum.values.length,
              );
            }
            return ChoiceChip(
              label: Text(
                PostsStatusEnum.values[index - 1].description,
              ),
              onSelected: (value) {
                if (onSelected != null) {
                  onSelected!([PostsStatusEnum.values[index - 1]]);
                }
              },
              selected: status.length == 1 &&
                  status.first.value == PostsStatusEnum.values[index - 1].value,
            );
          },
        ));
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant HeaderFilter oldDelegate) {
    return oldDelegate.status != status;
  }
}
