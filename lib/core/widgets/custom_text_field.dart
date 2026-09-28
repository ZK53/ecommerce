import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/app_svg.dart';

OutlineInputBorder _border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: color),
    );

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _hidden = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _hidden,
      keyboardType: widget.keyboardType,
      style: const TextStyle(fontSize: 13, color: AppColors.black),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.w500, color: AppColors.grey),
        filled: true,
        fillColor: AppColors.fieldBg,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(14),
                child: AppSvg(widget.prefixIcon!, size: 16, color: AppColors.grey),
              ),
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () => setState(() => _hidden = !_hidden),
                icon: Icon(
                  _hidden
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 18,
                  color: AppColors.grey,
                ),
              )
            : null,
        border: _border(AppColors.fieldBorder ),
        enabledBorder: _border(AppColors.fieldBorder),
        focusedBorder: _border(AppColors.primary),
      ),
    );
  }
}
