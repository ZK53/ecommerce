import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/utils/formatters.dart';
import 'package:stylish/core/widgets/app_svg.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/order_item_card.dart';
import 'package:stylish/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:stylish/features/cart/presentation/cubit/cart_state.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_state.dart';
import 'package:stylish/features/orders/presentation/view/my_orders_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderPlaceSuccess) {
          context.read<CartCubit>().clearCart();

          final orderCubit = context.read<OrderCubit>();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: orderCubit,
                child: const MyOrdersScreen(),
              ),
            ),
          );
        }

        if (state is OrderFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      child: Scaffold(
        appBar: const DetailAppBar(title: 'Checkout'),

        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  final cart = context.read<CartCubit>();
                  final items = cart.items;

                  if (items.isEmpty) {
                    return const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    children: [
                      const Row(
                        children: [
                          AppSvg(
                            AppIcons.location,
                            size: 14,
                            color: AppColors.black,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Delivery Address',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
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
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Type address here\nor pick from map',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.grey,
                                    ),
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
                              child: AppSvg(
                                AppIcons.location,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Shopping List',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: OrderItemCard(
                            image: item.product.imagePath,
                            name: item.product.name,
                            rating: item.product.rating.toString(),
                            itemLabel:
                                '${item.quantity} item${item.quantity == 1 ? '' : 's'}',
                            price: money(item.product.price),
                            oldPrice: '',
                            total: money(item.totalPrice),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    final isLoading = state is OrderLoading;

                    return CustomButton(
                      text: isLoading ? 'Placing Order...' : 'Place Order',

                      onPressed: isLoading
                          ? null
                          : () {
                              final cart = context.read<CartCubit>();

                              if (cart.items.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Your cart is empty'),
                                  ),
                                );
                                return;
                              }

                              context.read<OrderCubit>().placeOrder(
                                items: cart.items,
                              );
                            },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
