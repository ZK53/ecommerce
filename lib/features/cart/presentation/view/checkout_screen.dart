import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/utils/formatters.dart';
import 'package:stylish/core/widgets/app_svg.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/order_item_card.dart';
import 'package:stylish/features/orders/presentation/view/my_orders_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'Checkout'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              children: [
                const Row(
                  children: [
                    AppSvg(AppIcons.location, size: 14, color: AppColors.black),
                    SizedBox(width: 6),
                    Text(
                      'Delivery Address',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 79,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: AppShadows.card,
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Type address here\nor pick from map',
                              style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400, color: AppColors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: AppSvg(AppIcons.location, size: 30, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Shopping List',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
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
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: CustomButton(
                text: 'Place Order',
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MyOrdersScreen()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
