import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/cache/cache_helper.dart';
import 'package:stylish/core/cache/cache_keys.dart';
import 'package:stylish/core/widgets/stylish_logo.dart';
import 'package:stylish/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylish/features/auth/presentation/view/sign_in_screen.dart';
import 'package:stylish/features/main/view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;

      final accessToken = CacheHelper.getValue(key: CacheKeys.accessToken);

      if (accessToken != null && accessToken.toString().isNotEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => AuthCubit(),
              child: const SignInScreen(),
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: StylishLogo(height: 100, width: 275)),
    );
  }
}
