import 'package:stylish/features/cart/data/models/cart_item_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItemModel> items;

  CartUpdated(this.items);
}
