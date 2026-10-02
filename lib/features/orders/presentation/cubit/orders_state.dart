import 'package:stylish/features/orders/data/models/order_model.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderPlaceSuccess extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> active;
  final List<OrderModel> completed;
  final List<OrderModel> canceled;

  OrderSuccess({
    required this.active,
    required this.completed,
    required this.canceled,
  });
}

class OrderFailure extends OrderState {
  final String message;

  OrderFailure(this.message);
}

class OrderActionLoading extends OrderState {
  final int orderId;

  OrderActionLoading(this.orderId);
}

class OrderActionSuccess extends OrderState {
  final int orderId;

  OrderActionSuccess(this.orderId);
}
