import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/utils/formatters.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/order_item_card.dart';
import 'package:stylish/core/widgets/summary_row.dart';
import 'package:stylish/features/cart/presentation/view/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  static const _price1 = 34.0;
  static const _price2 = 45.0;
  static const _tax = 3.0;
  static const _delivery = 2.0;

  int _qty1 = 1;
  int _qty2 = 1;

  double get _subtotal => _qty1 * _price1 + _qty2 * _price2;
  double get _orderTotal => _subtotal + _tax + _delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'Cart'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                const Text(
                  'Shopping List',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                OrderItemCard(
                  image: AppImages.womensCasualWear,
                  name: "Women's Casual Wear",
                  price: money(_price1),
                  oldPrice: money(64),
                  total: money(_qty1 * _price1),
                  quantity: _qty1,
                  onQuantityChanged: (v) => setState(() => _qty1 = v),
                ),
                const SizedBox(height: 14),
                OrderItemCard(
                  image: AppImages.mensJacket,
                  name: "Men's Jacket",
                  rating: '4.7',
                  price: money(_price2),
                  oldPrice: money(67),
                  total: money(_qty2 * _price2),
                  quantity: _qty2,
                  onQuantityChanged: (v) => setState(() => _qty2 = v),
                ),
                const SizedBox(height: 16),
                const Divider(color: AppColors.divider),
                SummaryRow(label: 'Subtotal', value: money(_subtotal)),
                SummaryRow(label: 'Tax and Fees', value: money(_tax)),
                SummaryRow(label: 'Delivery Fee', value: money(_delivery)),
                const Divider(color: AppColors.divider),
                SummaryRow(label: 'Order Total', value: money(_orderTotal), bold: true),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: CustomButton(
                text: 'Place Order',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
