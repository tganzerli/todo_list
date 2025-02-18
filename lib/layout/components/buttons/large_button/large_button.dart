import 'package:flutter/material.dart';
import 'package:todo_list/layout/layout.dart';

class LargeButton extends StatelessWidget {
  final String title;
  final bool loading;
  final void Function()? onPressed;
  const LargeButton({
    super.key,
    required this.title,
    this.loading = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final text = Theme.of(context).textTheme;
    final spacing = AppSpacing.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(colors.primary),
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
                color: colors.cardBackground,
              ),
            )
          : Text(
              title,
              style: text.labelLarge!.copyWith(color: colors.cardBackground),
            ),
    );
  }
}
