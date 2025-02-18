import 'package:flutter/material.dart';
import 'package:todo_list/core/config/date_formatters.dart';
import 'package:todo_list/layout/layout.dart';

class CardDateField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;
  final void Function(String test, DateTime date)? onChanged;
  const CardDateField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.focusNode,
    this.errorText,
    this.onChanged,
  });

  @override
  State<CardDateField> createState() => _CardDateFieldState();
}

class _CardDateFieldState extends State<CardDateField> {
  late TextEditingController controller;

  void _setDate(DateTime date) {
    setState(() {
      controller.text = date.formatFullDate();
    });
    if (widget.onChanged != null) {
      widget.onChanged!(date.formatFullDate(), date);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    controller.text = DateTime.now().formatFullDate();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final spacing = AppSpacing.of(context);
    final text = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(spacing.spacingSM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label,
              style: text.labelMedium!.copyWith(color: colors.textSecondary),
            ),
            TextFormField(
              readOnly: true,
              controller: controller,
              focusNode: widget.focusNode,
              style: text.labelLarge,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle:
                    text.labelLarge!.copyWith(color: colors.textSecondary),
                errorStyle: text.titleSmall!.copyWith(color: Colors.red),
                errorText: widget.errorText,
                filled: true,
                fillColor: colors.cardBackground,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                suffixIcon:
                    Icon(Icons.calendar_today, color: colors.borderColor),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  _setDate(pickedDate);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
