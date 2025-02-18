import 'package:flutter/material.dart';
import 'package:todo_list/core/config/date_formatters.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/layout/layout.dart';

class InfoPostPage extends StatefulWidget {
  final PostsEntity post;
  const InfoPostPage({super.key, required this.post});

  @override
  State<InfoPostPage> createState() => _InfoPostPageState();
}

class _InfoPostPageState extends State<InfoPostPage> {
  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Post'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.marginApp),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              spacing: spacing.spacingXS,
              children: [
                SizedBox(height: spacing.spacingXS),
                Text(
                  widget.post.date.formatShortDate(),
                  style: text.titleMedium,
                ),
                StatusTags(staus: widget.post.status),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: spacing.marginApp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    spacing: spacing.marginApp,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'De:',
                            style: text.titleMedium,
                          ),
                          Text(
                            widget.post.user.name,
                            style: text.titleLarge,
                          )
                        ],
                      ),
                      ClipOval(
                        child: Image.asset(
                          widget.post.user.image,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: spacing.spacingXS),
                Text(
                  widget.post.title,
                  style: text.displayMedium,
                ),
                SizedBox(height: spacing.spacingXS),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(spacing.spacingXS),
                    child: Text(
                      widget.post.body,
                      style: text.titleMedium,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
