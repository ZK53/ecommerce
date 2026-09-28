import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';

/// زرار صغير مدوّر (Cancel / Track Driver / Cancel Order).
class SmallPillButton extends StatelessWidget {
  const SmallPillButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          minimumSize: const Size(0, 24),
          shape: const StadiumBorder(),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
