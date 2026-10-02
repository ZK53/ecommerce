import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/utils/validators.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/custom_text_field.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/features/main/view/main_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _createAccount() {
    if (_name.text.trim().isEmpty ||
        _phone.text.trim().isEmpty ||
        _password.text.isEmpty) {
      _showError('Please fill all the fields');
      return;
    }
    if (!isValidEmail(_email.text)) {
      _showError('Please enter a valid email');
      return;
    }
    if (_password.text != _confirm.text) {
      _showError('Passwords do not match');
      return;
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            const Text(
              'Create an\naccount',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700, ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: 'Full Name',
              controller: _name,
              prefixIcon: AppIcons.person,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Phone',
              controller: _phone,
              prefixIcon: AppIcons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Email',
              controller: _email,
              prefixIcon: AppIcons.mail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Password',
              controller: _password,
              prefixIcon: AppIcons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 12),
            CustomTextField(
              hintText: 'Confirm Password',
              controller: _confirm,
              prefixIcon: AppIcons.lock,
              obscureText: true,
            ),
            const SizedBox(height: 16),
            const Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 12, color: AppColors.grey, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: 'By clicking the '),
                  TextSpan(text: 'Register', style: TextStyle(color: AppColors.primary)),
                  TextSpan(text: ' button, you agree\nto the public offer'),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Center(child: CustomButton(text: 'Create Account', onPressed: _createAccount)),
          ],
        ),
      ),
    );
  }
}
