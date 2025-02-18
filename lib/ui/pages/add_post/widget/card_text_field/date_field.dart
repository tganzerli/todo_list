import 'package:flutter/material.dart';
import 'package:todo_list/core/config/injector.dart';
import 'package:todo_list/layout/layout.dart';
import 'package:todo_list/ui/pages/add_post/viewmodels/date_field_viewmodel.dart';

class DateField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(DateTime date)? onSubmmit;
  DateField({
    super.key,
    this.controller,
    this.onSubmmit,
  });

  final DateFieldViewmodel viewModel = injector.get<DateFieldViewmodel>();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.validator,
      builder: (context, child) {
        return CardDateField(
          label: 'Data do Post',
          controller: controller,
          onChanged: (text, date) => viewModel.validator.execute(date),
          errorText: viewModel.validator.leftResult?.message,
        );
      },
    );
  }
}
