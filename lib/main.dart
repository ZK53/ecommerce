import 'package:flutter/material.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/features/onboarding/presentation/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  runApp(const StylishApp());
}

class StylishApp extends StatelessWidget {
  const StylishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const SplashScreen(),
    );
  }
}

