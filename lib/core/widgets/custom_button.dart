import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';

/// الزرار الرئيسي. outlined = خلفية بيضا وبوردر أحمر (زي Register).
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.outlined = false,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool outlined;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final foreground = outlined ? AppColors.primary : Colors.white;
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(
          text,
          style: TextStyle(
            color: foreground,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
    final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));

    return SizedBox(
      width: 279,
      height: 55,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppColors.primary),
                shape: shape,
              ),
              child: child,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                elevation: 0,
                shape: shape,
              ),
              child: child,
            ),
    );
  }
}
