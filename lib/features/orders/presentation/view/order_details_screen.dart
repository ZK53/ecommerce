import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/utils/formatters.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/order_item_card.dart';
import 'package:stylish/core/widgets/small_pill_button.dart';
import 'package:stylish/core/widgets/summary_row.dart';
import 'package:stylish/features/orders/presentation/view/widgets/order_card.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.status});

  final OrderStatus status;

  String get _statusLabel {
    switch (status) {
      case OrderStatus.active:
        return 'Active';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'Order Details'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order No. 005', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text('29 Nov, 01:20 pm', style: TextStyle(fontSize: 10, color: AppColors.grey)),
                ],
              ),
              Text(_statusLabel, style: const TextStyle(fontSize: 14, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 16),
          OrderItemCard(
            image: AppImages.womensCasualWear,
            name: "Women's Casual Wear",
            itemLabel: '1 item',
            price: money(34),
            oldPrice: money(64),
            total: money(34),
          ),
          const SizedBox(height: 14),
          OrderItemCard(
            image: AppImages.mensJacket,
            name: "Men's Jacket",
            rating: '4.7',
            itemLabel: '1 item',
            price: money(45),
            oldPrice: money(67),
            total: money(45),
          ),
          const SizedBox(height: 16),
          SummaryRow(label: 'Subtotal', value: money(79)),
          SummaryRow(label: 'Tax and Fees', value: money(3)),
          SummaryRow(label: 'Delivery Fee', value: money(2)),
          const Divider(color: AppColors.divider),
          SummaryRow(label: 'Order Total', value: money(84), bold: true),
          if (status == OrderStatus.active) ...[
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallPillButton(
                  text: 'Cancel Order',
                  onPressed: () => Navigator.pop(context, 'cancelled'),
                ),
                const SizedBox(width: 12),
                SmallPillButton(
                  text: 'Track Driver',
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Driver is on the way')),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
