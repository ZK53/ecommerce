import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/features/category/data/models/category_model.dart';

/// صف الكاتيجوريز الدايرية (Beauty / Fashion / Kids / Mens / Womens).
/// selectedIndex و onChanged اختياريين.
class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.categories,
    this.selectedIndex,
    this.onChanged,
  });

  final List<CategoryModel> categories;
  final int? selectedIndex;
  final ValueChanged<int>? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: onChanged == null ? null : () => onChanged!(i),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: selected
                      ? AppColors.primary
                      : Colors.transparent,
                  child: CircleAvatar(
                    radius: selected ? 28 : 30,
                    backgroundImage: NetworkImage(categories[i].imagePath),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  categories[i].title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: selected ? AppColors.primary : AppColors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
