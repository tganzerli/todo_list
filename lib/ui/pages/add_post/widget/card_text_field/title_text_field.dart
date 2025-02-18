import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/pages/add_post/viewmodels/title_text_field_viewmodel.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String text)? onSubmmit;
  TitleTextField({
    super.key,
    this.controller,
    this.onSubmmit,
  });

  final TitleTextFieldViewmodel viewModel =
      injector.get<TitleTextFieldViewmodel>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.validator,
      builder: (context, child) {
        return CardTextField(
          label: 'Titulo do Post',
          hintText: 'Post',
          controller: controller,
          onSubmmit: onSubmmit,
          onChanged: (text) => viewModel.validator.execute(text),
          errorText: viewModel.validator.leftResult?.message,
        );
      },
    );
  }
}
