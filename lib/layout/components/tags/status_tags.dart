import 'package:flutter/material.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/layout/layout.dart';

class StatusTags extends StatelessWidget {
  final PostsStatusEnum staus;
  const StatusTags({super.key, required this.staus});

  Color backgroundColor(AppColors colors) {
    return switch (staus) {
      PostsStatusEnum.todo => colors.blueSecondary,
      PostsStatusEnum.inProgress => colors.orangeSecondary,
      PostsStatusEnum.complete => colors.secondary,
    };
  }

  Color testColor(AppColors colors) {
    return switch (staus) {
      PostsStatusEnum.todo => colors.bluePrimary,
      PostsStatusEnum.inProgress => colors.orangePrimary,
      PostsStatusEnum.complete => colors.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: spacing.spacingXS,
          vertical: spacing.spacingXXS,
        ),
        decoration: BoxDecoration(
            color: backgroundColor(colors),
            borderRadius: BorderRadius.circular(spacing.spacingLG)),
        child: Text(
          staus.description,
          style: text.labelMedium!.copyWith(color: testColor(colors)),
        ));
  }
}
