import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/cart/data/models/cart_item_model.dart';
import 'package:stylish/features/orders/data/models/order_model.dart';
import 'package:stylish/features/orders/data/repo/order_repo.dart';
import 'package:stylish/features/orders/presentation/cubit/orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  final OrderRepo _repo = OrderRepo();

  Future<void> placeOrder({required List<CartItemModel> items}) async {
    emit(OrderLoading());

    try {
      final orderItems = items.map((item) {
        return {'product_id': item.product.id, 'quantity': item.quantity};
      }).toList();

      await _repo.placeOrder(items: orderItems);

      emit(OrderPlaceSuccess());
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> getOrders() async {
    emit(OrderLoading());

    try {
      final response = await _repo.getOrders();

      if (response is! Map<String, dynamic>) {
        throw Exception('Invalid orders response');
      }

      final ordersData = response['orders'];

      if (ordersData is! Map<String, dynamic>) {
        throw Exception('Invalid orders data');
      }

      final List<OrderModel> active = [];
      final List<OrderModel> completed = [];
      final List<OrderModel> canceled = [];

      final activeData = ordersData['active'];

      if (activeData is List) {
        active.addAll(
          activeData.whereType<Map<String, dynamic>>().map(OrderModel.fromJson),
        );
      }

      final completedData = ordersData['completed'];

      if (completedData is List) {
        completed.addAll(
          completedData.whereType<Map<String, dynamic>>().map(
            OrderModel.fromJson,
          ),
        );
      }

      final canceledData = ordersData['canceled'];

      if (canceledData is List) {
        canceled.addAll(
          canceledData.whereType<Map<String, dynamic>>().map(
            OrderModel.fromJson,
          ),
        );
      }

      emit(
        OrderSuccess(active: active, completed: completed, canceled: canceled),
      );
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> cancelOrder(int orderId) async {
    emit(OrderActionLoading(orderId));

    try {
      await _repo.cancelOrder(orderId: orderId);

      emit(OrderActionSuccess(orderId));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }

  Future<void> completeOrder(int orderId) async {
    emit(OrderActionLoading(orderId));

    try {
      await _repo.completeOrder(orderId: orderId);

      emit(OrderActionSuccess(orderId));
    } catch (e) {
      emit(OrderFailure(e.toString()));
    }
  }
}
