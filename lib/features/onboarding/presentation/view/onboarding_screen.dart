import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/features/onboarding/presentation/view/get_started_screen.dart';
import 'package:stylish/features/onboarding/presentation/view/widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _description =
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet '
      'sint. Velit officia consequat duis enim velit mollit.';

  static const _pages = [
    (image: AppImages.onboarding1, title: 'Choose Products'),
    (image: AppImages.onboarding2, title: 'Make Payment'),
    (image: AppImages.onboarding3, title: 'Get Your Order'),
  ];

  final _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == _pages.length - 1;

  void _goToGetStarted() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GetStartedScreen()),
    );
  }

  void _move(int page) {
    _controller.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _goToGetStarted,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) => OnboardingPage(
                  image: _pages[i].image,
                  title: _pages[i].title,
                  description: _description,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 90,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _index == 0
                          ? null
                          : TextButton(
                              onPressed: () => _move(_index - 1),
                              child: const Text(
                                'Prev',
                                style: TextStyle(color: AppColors.lightGrey),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    children: List.generate(_pages.length, (i) {
                      final active = i == _index;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 36 : 8,
                        height: active ? 5 : 8,
                        decoration: BoxDecoration(
                          color: active ? AppColors.navy : AppColors.divider,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    width: 90,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _isLast
                            ? _goToGetStarted
                            : () => _move(_index + 1),
                        child: Text(
                          _isLast ? 'Get Started' : 'Next',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
