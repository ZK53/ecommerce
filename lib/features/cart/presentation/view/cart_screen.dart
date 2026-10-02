import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/utils/formatters.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/order_item_card.dart';
import 'package:stylish/core/widgets/summary_row.dart';

import 'package:stylish/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:stylish/features/cart/presentation/cubit/cart_state.dart';
import 'package:stylish/features/cart/presentation/view/checkout_screen.dart';

import 'package:stylish/features/orders/presentation/cubit/orders_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const double tax = 3.0;
  static const double delivery = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'Cart'),

      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCubit = context.read<CartCubit>();
          final items = cartCubit.items;

          if (items.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
            );
          }

          final subtotal = cartCubit.subtotal;
          final orderTotal = subtotal + tax + delivery;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  children: [
                    const Text(
                      'Shopping List',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    ...items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: OrderItemCard(
                          image: item.product.imagePath,
                          name: item.product.name,
                          price: money(item.product.price),
                          total: money(item.totalPrice),
                          quantity: item.quantity,

                          onQuantityChanged: (value) {
                            final currentQuantity = item.quantity;

                            if (value > currentQuantity) {
                              for (int i = currentQuantity; i < value; i++) {
                                cartCubit.increaseQuantity(item.product.id);
                              }
                            } else if (value < currentQuantity) {
                              for (int i = value; i < currentQuantity; i++) {
                                cartCubit.decreaseQuantity(item.product.id);
                              }
                            }
                          },
                        ),
                      );
                    }),

                    const Divider(color: AppColors.divider),

                    SummaryRow(label: 'Subtotal', value: money(subtotal)),

                    const SummaryRow(label: 'Tax and Fees', value: 'EGP 3.00'),

                    const SummaryRow(label: 'Delivery Fee', value: 'EGP 2.00'),

                    const Divider(color: AppColors.divider),

                    SummaryRow(
                      label: 'Order Total',
                      value: money(orderTotal),
                      bold: true,
                    ),
                  ],
                ),
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  child: CustomButton(
                    text: 'Place Order',

                    onPressed: () {
                      final cartCubit = context.read<CartCubit>();

                      final orderCubit = context.read<OrderCubit>();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(value: cartCubit),
                              BlocProvider.value(value: orderCubit),
                            ],
                            child: const CheckoutScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
