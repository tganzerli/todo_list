import 'package:flutter/material.dart';
import 'package:todo_list/layout/layout.dart';

class HeaderMyPosts extends SliverPersistentHeaderDelegate {
  const HeaderMyPosts();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colors = AppColors.of(context);
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Container(
        color: colors.scaffoldBackground,
        height: maxExtent,
        padding: EdgeInsets.symmetric(horizontal: spacing.marginApp),
        alignment: Alignment.centerLeft,
        child: Text(
          'Meus Posts',
          style: text.titleLarge,
        ));
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant HeaderMyPosts oldDelegate) => false;
}
