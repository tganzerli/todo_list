import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/pages/add_post/viewmodels/body_text_field_viewmodel.dart';

class BodyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String text)? onSubmmit;
  BodyTextField({
    super.key,
    this.controller,
    this.onSubmmit,
  });

  final BodyTextFieldViewmodel viewModel =
      injector.get<BodyTextFieldViewmodel>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.validator,
      builder: (context, child) {
        return CardTextField(
          label: 'Descrição do Post',
          hintText: 'Descrição',
          controller: controller,
          onSubmmit: onSubmmit,
          isMultiline: true,
          onChanged: (text) => viewModel.validator.execute(text),
          errorText: viewModel.validator.leftResult?.message,
        );
      },
    );
  }
}
