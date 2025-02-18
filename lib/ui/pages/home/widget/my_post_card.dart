import 'package:flutter/material.dart';
import 'package:todo_list/core/config/date_formatters.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/domain/entities/posts_entity.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/pages/home/viewmodels/my_post_card_viewmodel.dart';

class MyPostCard extends StatelessWidget {
  final PostsEntity post;
  final void Function()? onSelected;
  MyPostCard({
    super.key,
    required this.post,
    this.onSelected,
  });

  final MyPostCardViewModel viewModel = injector.get<MyPostCardViewModel>();

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Card(
      child: GestureDetector(
        onTap: onSelected,
        child: Container(
          height: 82,
          color: Colors.transparent,
          padding: EdgeInsets.all(spacing.spacingSM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: spacing.spacingXS,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.date.formatShortDate(),
                      style: text.titleSmall,
                    ),
                    Text(
                      post.title,
                      style: text.titleMedium,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Center(child: _action(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget _action(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.updatePostEvent,
      builder: (context, _) {
        return switch (post.status) {
          PostsStatusEnum.todo => SizedBox(
              height: 30,
              child: SmallButtom(
                type: SmallButtomType.blue,
                title: 'Iniciar',
                onPressed: () => viewModel.updatePostEvent.execute(post),
                loading: viewModel.updatePostEvent.isExecuting,
              )),
          PostsStatusEnum.inProgress => SizedBox(
              height: 30,
              child: SmallButtom(
                type: SmallButtomType.orange,
                title: 'Finalizar',
                onPressed: () => viewModel.updatePostEvent.execute(post),
                loading: viewModel.updatePostEvent.isExecuting,
              )),
          PostsStatusEnum.complete => StatusTags(
              staus: PostsStatusEnum.complete,
            ),
        };
      },
    );
  }
}
