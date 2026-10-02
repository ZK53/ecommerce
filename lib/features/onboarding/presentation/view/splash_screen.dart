import 'package:flutter/material.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_keys.dart';
import 'package:stylish/core/widgets/stylish_logo.dart';
import 'package:stylish/features/main/view/main_screen.dart';
import 'package:stylish/features/onboarding/presentation/view/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final accessToken = CacheHelper.getValue(key: CacheKeys.accessToken);

    final isLoggedIn = accessToken != null && accessToken.toString().isNotEmpty;

    if (isLoggedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const MainScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const GetStartedScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: StylishLogo(height: 100, width: 275)),
    );
  }
}
