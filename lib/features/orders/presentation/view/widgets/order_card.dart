import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/widgets/small_pill_button.dart';

enum OrderStatus { active, completed, cancelled }

/// كارت الأوردر في شاشة My Orders.
class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.status,
    this.onTap,
    this.onCancel,
    this.onTrack,
  });

  final OrderStatus status;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onTrack;

  Widget _bottom() {
    switch (status) {
      case OrderStatus.active:
        return Row(
          children: [
            Expanded(child: SmallPillButton(text: 'Cancel', onPressed: onCancel)),
            const SizedBox(width: 8),
            Expanded(child: SmallPillButton(text: 'Track Driver', onPressed: onTrack)),
          ],
        );
      case OrderStatus.completed:
        return const _StatusLine(icon: Icons.check_circle_outline, text: 'Order delivered');
      case OrderStatus.cancelled:
        return const _StatusLine(icon: Icons.highlight_off, text: 'Order Canceled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: AppShadows.card,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                color: AppColors.imageBg,
                child: Image.asset(AppImages.shirt, width: 72, height: 72, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mens Starry', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                      Text('\$ 50', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('15/05/2005 1:30 pm', style: TextStyle(fontSize: 9, color: AppColors.grey)),
                      Text('1 item', style: TextStyle(fontSize: 9, color: AppColors.grey)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _bottom(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusLine extends StatelessWidget {
  const _StatusLine({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 10, color: AppColors.primary)),
      ],
    );
  }
}
