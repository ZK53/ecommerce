import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/features/favorites/presentation/view/favorites_screen.dart';
import 'package:stylish/features/onboarding/presentation/view/get_started_screen.dart';
import 'package:stylish/features/orders/presentation/view/my_orders_screen.dart';

/// محتوى تاب Profile — مش موجود في التصميم، ده مجرد نقطة دخول
/// لشاشات My Orders و My Favorites.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 20),
          _ProfileTile(
            icon: Icons.receipt_long_outlined,
            label: 'My Orders',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _ProfileTile(
            icon: Icons.favorite_border,
            label: 'My Favorites',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FavoritesScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _ProfileTile(
            icon: Icons.logout,
            label: 'Log out',
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const GetStartedScreen()),
              (route) => false,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  const _ProfileTile({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.black),
            const SizedBox(width: 12),
            Expanded(
              child: Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            const Icon(Icons.chevron_right, color: AppColors.grey),
          ],
        ),
      ),
    );
  }
}
