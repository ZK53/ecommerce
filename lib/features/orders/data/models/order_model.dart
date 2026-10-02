class OrderItemModel {
  final int productId;
  final int quantity;
  final String name;
  final String image;
  final double price;
  final double rating;
  final double totalPrice;

  OrderItemModel({
    required this.productId,
    required this.quantity,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.totalPrice,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      productId: json['id'] ?? 0,
      quantity: json['quantity'] ?? 1,
      name: json['name'] ?? '',
      image: json['image_path'] ?? '',
      price: _toDouble(json['price']),
      rating: _toDouble(json['rating']),
      totalPrice: _toDouble(json['total_price']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    return double.tryParse(value.toString()) ?? 0;
  }
}

class OrderModel {
  final int id;
  final int status;
  final String orderDate;
  final String? orderChangeDate;
  final double shipping;
  final double subtotal;
  final double tax;
  final double total;
  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.orderDate,
    this.orderChangeDate,
    required this.shipping,
    required this.subtotal,
    required this.tax,
    required this.total,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? 0,
      orderDate: json['order_date'] ?? '',
      orderChangeDate: json['order_change_date'],
      shipping: _toDouble(json['shipping']),
      subtotal: _toDouble(json['subtotal']),
      tax: _toDouble(json['tax']),
      total: _toDouble(json['total']),
      items: json['items'] is List
          ? (json['items'] as List)
                .whereType<Map<String, dynamic>>()
                .map(OrderItemModel.fromJson)
                .toList()
          : [],
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    return double.tryParse(value.toString()) ?? 0;
  }
}
