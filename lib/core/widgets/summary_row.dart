import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';

/// سطر (Subtotal / Tax / Delivery / Order Total).
class SummaryRow extends StatelessWidget {
  const SummaryRow({super.key, required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: bold ? 14 : 12, fontWeight: FontWeight.w400),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: bold ? 14 : 12,
              fontWeight: FontWeight.w700,
              color: bold ? AppColors.primary : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
