import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/features/cart/data/models/cart_item_model.dart';
import 'package:stylish/features/cart/presentation/cubit/cart_state.dart';
import 'package:stylish/features/product/data/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => List.unmodifiable(_items);

  int get totalItems {
    return _items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get subtotal {
    return _items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  void addToCart({required ProductModel product, int quantity = 1}) {
    final index = _items.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItemModel(product: product, quantity: quantity));
    }

    emit(CartUpdated(List.from(_items)));
  }

  void increaseQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      _items[index].quantity++;
      emit(CartUpdated(List.from(_items)));
    }
  }

  void decreaseQuantity(int productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);

    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }

      emit(CartUpdated(List.from(_items)));
    }
  }

  void removeFromCart(int productId) {
    _items.removeWhere((item) => item.product.id == productId);

    emit(CartUpdated(List.from(_items)));
  }

  void clearCart() {
    _items.clear();

    emit(CartUpdated(List.from(_items)));
  }
}
