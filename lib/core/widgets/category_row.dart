import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';

/// صف الكاتيجوريز الدايرية (Beauty / Fashion / Kids / Mens / Womens).
/// selectedIndex و onChanged اختياريين.
class CategoryRow extends StatelessWidget {
  const CategoryRow({super.key, this.selectedIndex, this.onChanged});

  final int? selectedIndex;
  final ValueChanged<int>? onChanged;

  static const _items = [
    (label: 'Beauty', image: AppImages.categoryBeauty),
    (label: 'Fashion', image: AppImages.categoryFashion),
    (label: 'Kids', image: AppImages.categoryKids),
    (label: 'Mens', image: AppImages.categoryMens),
    (label: 'Womens', image: AppImages.categoryWomens),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: onChanged == null ? null : () => onChanged!(i),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: selected ? AppColors.primary : Colors.transparent,
                  child: CircleAvatar(
                    radius: selected ? 28 : 30,
                    backgroundImage: AssetImage(_items[i].image),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _items[i].label,
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
