import 'package:flutter/material.dart';
import 'package:todo_list/layout/layout.dart';

class CardTextField extends StatefulWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? errorText;
  final bool isMultiline;
  final TextInputType? keyboardType;
  final void Function(String text)? onSubmmit;
  final void Function(String)? onChanged;
  const CardTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.focusNode,
    this.errorText,
    this.isMultiline = false,
    this.keyboardType,
    this.onSubmmit,
    this.onChanged,
  });

  @override
  State<CardTextField> createState() => _CardTextFieldState();
}

class _CardTextFieldState extends State<CardTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
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
            SizedBox(height: widget.isMultiline ? spacing.spacingXS : 0),
            TextFormField(
              controller: controller,
              focusNode: widget.focusNode,
              style: text.labelLarge,
              minLines: widget.isMultiline ? 5 : null,
              maxLines: widget.isMultiline ? null : 1,
              keyboardType: widget.isMultiline
                  ? TextInputType.multiline
                  : widget.keyboardType,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
                if (widget.onSubmmit != null) {
                  widget.onSubmmit!(controller.text);
                }
              },
              onSaved: widget.onSubmmit == null
                  ? null
                  : (_) => widget.onSubmmit!(controller.text),
              onChanged: widget.onChanged,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
