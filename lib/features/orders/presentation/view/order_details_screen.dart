import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/utils/formatters.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/order_item_card.dart';
import 'package:stylish/core/widgets/small_pill_button.dart';
import 'package:stylish/core/widgets/summary_row.dart';

import 'package:stylish/features/orders/data/models/order_model.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_state.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  String get _statusLabel {
    switch (order.status) {
      case 0:
        return 'Active';

      case 1:
        return 'Completed';

      case 2:
        return 'Cancelled';

      default:
        return 'Unknown';
    }
  }

  bool get _isActive {
    return order.status == 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is OrderActionSuccess && state.orderId == order.id) {
          Navigator.pop(context, 'cancelled');
        }

        if (state is OrderFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: const DetailAppBar(title: 'Order Details'),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order No. ${order.id}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.orderDate,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  _statusLabel,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            ...order.items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: OrderItemCard(
                  image: item.image,
                  name: item.name,
                  rating: item.rating.toString(),
                  itemLabel: '${item.quantity} item',
                  price: money(item.price),
                  oldPrice: '',
                  total: money(item.totalPrice),
                ),
              ),
            ),

            const SizedBox(height: 2),

            SummaryRow(label: 'Subtotal', value: money(order.subtotal)),

            SummaryRow(label: 'Tax and Fees', value: money(order.tax)),

            SummaryRow(label: 'Delivery Fee', value: money(order.shipping)),

            const Divider(color: AppColors.divider),

            SummaryRow(
              label: 'Order Total',
              value: money(order.total),
              bold: true,
            ),

            if (_isActive) ...[
              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      final isLoading =
                          state is OrderActionLoading &&
                          state.orderId == order.id;

                      return SmallPillButton(
                        text: isLoading ? 'Cancelling...' : 'Cancel Order',
                        onPressed: isLoading
                            ? null
                            : () {
                                context.read<OrderCubit>().cancelOrder(
                                  order.id,
                                );
                              },
                      );
                    },
                  ),

                  const SizedBox(width: 12),

                  SmallPillButton(
                    text: 'Track Driver',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Driver is on the way')),
                      );
                    },
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
