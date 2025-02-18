import 'package:flutter/material.dart';
import 'package:todo_list/core/config/date_formatters.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/app_routes.dart';

class PostCard extends StatelessWidget {
  final PostsEntity post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Card(
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.infoPost, arguments: post),
        child: Container(
          height: 110,
          color: Colors.transparent,
          padding: EdgeInsets.all(spacing.spacingSM),
          child: Column(
            spacing: spacing.spacingXXS,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post.date.formatShortDate(),
                    style: text.titleSmall,
                  ),
                  StatusTags(staus: post.status)
                ],
              ),
              Row(
                spacing: spacing.spacingSM,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClipOval(
                    child: Image.asset(
                      post.user.image,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    post.user.name,
                    style: text.titleMedium,
                  ),
                ],
              ),
              SizedBox(
                height: spacing.spacingXXS,
              ),
              Text(post.title,
                  style: text.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ),
    );
  }
}
