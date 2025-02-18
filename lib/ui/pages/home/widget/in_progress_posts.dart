import 'package:flutter/material.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/app_routes.dart';

class InProgressPosts extends StatelessWidget {
  final List<PostsEntity> posts;
  InProgressPosts({super.key, required this.posts});

  final PageController _pageController = PageController(viewportFraction: 0.8);

  Color backgroundColor(AppColors colors, int index) {
    List<Color> colorsList = [
      colors.blueSecondary,
      colors.orangeSecondary,
      colors.secondary
    ];
    return colorsList[index % colorsList.length];
  }

  Color testColor(AppColors colors, int index) {
    List<Color> colorsList = [
      colors.bluePrimary,
      colors.orangePrimary,
      colors.primary
    ];
    return colorsList[index % colorsList.length];
  }

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spacing.spacingSM,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing.marginApp),
            child: Text(
              'Em Andamento',
              style: text.titleLarge,
            ),
          ),
          SizedBox(
            height: 136,
            child: PageView.builder(
              controller: _pageController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return buildSliderItem(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliderItem(BuildContext context, int postIndex) {
    final colors = AppColors.of(context);
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: spacing.spacingXS),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppRoutes.infoPost,
            arguments: posts[postIndex]),
        child: Card(
          color: backgroundColor(colors, postIndex),
          child: Padding(
            padding: EdgeInsets.all(spacing.marginApp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: spacing.spacingXS,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: spacing.spacingSM,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        posts[postIndex].user.image,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      posts[postIndex].user.name,
                      style: text.titleLarge,
                    )
                  ],
                ),
                Text(
                  posts[postIndex].title,
                  style: text.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
