import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/utils/validators.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/custom_text_field.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylish/features/auth/presentation/cubit/auth_state.dart';
import 'package:stylish/features/main/view/main_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _login() {
    if (!isValidEmail(_email.text) || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email and password'),
        ),
      );
      return;
    }

    context.read<AuthCubit>().login(
      email: _email.text.trim(),
      password: _password.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MainScreen()),
            (route) => false,
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: const DetailAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              const Text(
                'Welcome\nBack!',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 50),
              CustomTextField(
                hintText: 'Email',
                controller: _email,
                prefixIcon: AppIcons.mail,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                hintText: 'Password',
                controller: _password,
                prefixIcon: AppIcons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 40),
              Center(
                child: CustomButton(text: 'Login', onPressed: _login),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
