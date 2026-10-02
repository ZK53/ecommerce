import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key, this.count = 3});

  final int count;

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            itemCount: widget.count,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, _) => const _PromoSlide(),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.count, (i) {
            final active = i == _index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: active ? 10 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _PromoSlide extends StatelessWidget {
  const _PromoSlide();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFF6E88), Color(0xFFFFA9B8)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(AppImages.promoModel, fit: BoxFit.contain),
          ),
          
        ],
      ),
    );
  }
}
