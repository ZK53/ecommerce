import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/widgets/app_svg.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.controller,
    this.onTap,
    this.onChanged,
    this.readOnly = false,
    this.hintText = 'Search any Product..',
  });

  final TextEditingController? controller;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool readOnly;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: AppShadows.card,
      ),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 12, color: AppColors.lightGrey),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          prefixIcon: const Padding(
            padding: EdgeInsets.all(14),
            child: AppSvg(AppIcons.search, size: 16, color: AppColors.grey),
          ),
        ),
      ),
    );
  }
}
