import 'package:flutter/material.dart';

import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/widgets/small_pill_button.dart';
import 'package:stylish/features/orders/data/models/order_model.dart';

enum OrderStatus { active, completed, cancelled }

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onCancel,
    this.onTrack,
  });

  final OrderModel order;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onTrack;

  OrderStatus get _status {
    switch (order.status) {
      case 0:
        return OrderStatus.active;

      case 1:
        return OrderStatus.completed;

      case 2:
        return OrderStatus.cancelled;

      default:
        return OrderStatus.active;
    }
  }

  Widget _bottom() {
    switch (_status) {
      case OrderStatus.active:
        return Row(
          children: [
            Expanded(
              child: SmallPillButton(text: 'Cancel', onPressed: onCancel),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SmallPillButton(text: 'Track Driver', onPressed: onTrack),
            ),
          ],
        );

      case OrderStatus.completed:
        return const _StatusLine(
          icon: Icons.check_circle_outline,
          text: 'Order delivered',
        );

      case OrderStatus.cancelled:
        return const _StatusLine(
          icon: Icons.highlight_off,
          text: 'Order Canceled',
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstItem = order.items.isNotEmpty ? order.items.first : null;

    final itemCount = order.items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

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
                child: firstItem != null
                    ? Image(
                        image: firstItem.image.startsWith('http')
                            ? NetworkImage(firstItem.image)
                            : AssetImage(firstItem.image),
                        width: 72,
                        height: 72,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            width: 72,
                            height: 72,
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: AppColors.grey,
                            ),
                          );
                        },
                      )
                    : const SizedBox(
                        width: 72,
                        height: 72,
                        child: Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.grey,
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          firstItem?.name ?? 'Order',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        '\$ ${order.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          order.orderDate,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        '$itemCount item${itemCount == 1 ? '' : 's'}',
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.grey,
                        ),
                      ),
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
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: AppColors.primary),
        ),
      ],
    );
  }
}
