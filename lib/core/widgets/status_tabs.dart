import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';

/// تابات على شكل حبوب (Active / Completed / Cancelled).
class StatusTabs extends StatelessWidget {
  const StatusTabs({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(labels.length, (i) {
        final selected = i == selectedIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(i),
            child: Container(
              height: 28,
              margin: EdgeInsets.only(right: i == labels.length - 1 ? 0 : 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                labels[i],
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : AppColors.primary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
