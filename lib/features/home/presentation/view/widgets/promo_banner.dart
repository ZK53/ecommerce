import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/features/silder/data/models/slider_model.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key, required this.sliders});

  final List<SliderModel> sliders;

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
            itemCount: widget.sliders.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              return _PromoSlide(slider: widget.sliders[i]);
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.sliders.length, (i) {
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
  const _PromoSlide({required this.slider});

  final SliderModel slider;

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          slider.imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
