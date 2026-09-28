import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/app_svg.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/status_tabs.dart';
import 'package:stylish/features/orders/view/order_details_screen.dart';
import 'package:stylish/features/orders/view/widgets/order_card.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int _tab = 0;
  bool _hasActive = true;
  bool _hasCancelled = false;

  void _cancelOrder() {
    setState(() {
      _hasActive = false;
      _hasCancelled = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order cancelled')),
    );
  }

  void _track() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Driver is on the way')),
    );
  }

  Future<void> _openDetails(OrderStatus status) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => OrderDetailsScreen(status: status)),
    );
    if (result == 'cancelled' && status == OrderStatus.active) _cancelOrder();
  }

  Widget _body() {
    switch (_tab) {
      case 0:
        return _hasActive
            ? OrderCard(
                status: OrderStatus.active,
                onTap: () => _openDetails(OrderStatus.active),
                onCancel: _cancelOrder,
                onTrack: _track,
              )
            : const _EmptyOrders(message: "You don't have any\nactive orders at this\ntime");
      case 1:
        return OrderCard(
          status: OrderStatus.completed,
          onTap: () => _openDetails(OrderStatus.completed),
        );
      default:
        return _hasCancelled
            ? OrderCard(
                status: OrderStatus.cancelled,
                onTap: () => _openDetails(OrderStatus.cancelled),
              )
            : const _EmptyOrders(message: "You don't have any\ncancelled orders at\nthis time");
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
              onChanged: (i) => setState(() => _tab = i),
            ),
            const SizedBox(height: 20),
            Expanded(child: SingleChildScrollView(child: _body())),
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
