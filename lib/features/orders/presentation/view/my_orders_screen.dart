import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/app_svg.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/status_tabs.dart';

import 'package:stylish/features/orders/data/models/order_model.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_state.dart';
import 'package:stylish/features/orders/presentation/view/order_details_screen.dart';
import 'package:stylish/features/orders/presentation/view/widgets/order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tab = 0;

  @override
  void initState() {
    super.initState();

    context.read<OrderCubit>().getOrders();
  }

  Future<void> _openDetails(OrderModel order) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => OrderDetailsScreen(order: order)),
    );

    if (result == 'cancelled' && mounted) {
      context.read<OrderCubit>().getOrders();
    }
  }

  Widget _ordersList(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return const _EmptyOrders(
        message: "You don't have any\norders at this time",
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final order = orders[index];

        return OrderCard(order: order, onTap: () => _openDetails(order));
      },
    );
  }

  Widget _body(OrderSuccess state) {
    switch (_tab) {
      case 0:
        return _ordersList(state.active);

      case 1:
        return _ordersList(state.completed);

      case 2:
        return _ordersList(state.canceled);

      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'My Orders'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          children: [
            StatusTabs(
              labels: const ['Active', 'Completed', 'Cancelled'],
              selectedIndex: _tab,
              onChanged: (i) {
                setState(() {
                  _tab = i;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is OrderFailure) {
                    return Center(
                      child: Text(state.message, textAlign: TextAlign.center),
                    );
                  }

                  if (state is OrderSuccess) {
                    return RefreshIndicator(
                      onRefresh: () {
                        return context.read<OrderCubit>().getOrders();
                      },
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: _body(state),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppSvg(AppIcons.emptyOrders, size: 200),

          const SizedBox(height: 20),

          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
