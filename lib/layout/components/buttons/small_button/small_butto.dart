import 'package:flutter/material.dart';
import 'package:todo_list/layout/layout.dart';

export 'small_button_enum.dart';

class SmallButtom extends StatelessWidget {
  final SmallButtomType type;
  final String title;
  final bool loading;
  final void Function()? onPressed;
  const SmallButtom({
    super.key,
    this.type = SmallButtomType.primary,
    required this.title,
    this.loading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final spacing = AppSpacing.of(context);
    return TextButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(type.backgroundColor),
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(spacing.spacingXS),
        )),
      ),
      onPressed: loading ? null : onPressed,
      child: loading
          ? SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: type.textColor,
              ),
            )
          : Text(
              title,
              style: text.labelMedium!.copyWith(color: type.textColor),
            ),
    );
  }
}
