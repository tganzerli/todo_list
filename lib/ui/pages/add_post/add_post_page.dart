import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/domain/enums/posts_status_enum.dart';
import 'package:todo_list/domain/parameters/post_add_parameter.dart';
import 'package:todo_list/layout/layout.dart';

import 'viewmodels/add_post_viewmodel.dart';
import 'viewmodels/add_post_viewmodel_state.dart';
import 'widget/card_text_field/body_text_field.dart';
import 'widget/card_text_field/date_field.dart';
import 'widget/card_text_field/title_text_field.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  final AddPostViewModel viewModel = injector.get<AddPostViewModel>();

  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  DateTime dateController = DateTime.now();

  void listener() {
    AddPostViewmodelState state = viewModel.state;
    if (state is AddPostSuccess) {
      Navigator.pop(context);
    }
    if (state is AddPostError) {
      print(state.message);
    }
  }

  @override
  void initState() {
    super.initState();
    viewModel.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    final spacing = AppSpacing.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Post'),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: viewModel,
        builder: (context, state, _) {
          return SizedBox(
            height: 80,
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 42,
                child: LargeButton(
                  title: 'Adicionar',
                  loading: state is AddPostLoading,
                  onPressed: () => viewModel.addEvent.execute(PostAddParameter(
                      title: titleController.text,
                      body: bodyController.text,
                      date: dateController,
                      status: PostsStatusEnum.todo)),
                ),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing.marginApp),
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              spacing: spacing.spacingXS,
              children: [
                TitleTextField(
                  controller: titleController,
                ),
                BodyTextField(
                  controller: bodyController,
                ),
                DateField(
                  onSubmmit: (date) {
                    dateController = date;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
