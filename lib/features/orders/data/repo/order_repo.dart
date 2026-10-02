import 'package:stylish/core/newtwork/api_helper.dart';
import 'package:stylish/core/newtwork/enpoints.dart';

class OrderRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<void> placeOrder({required List<Map<String, dynamic>> items}) async {
    await apiHelper.postRequest(
      endPoint: Enpoints.placeOrder,
      data: {'items': items},
      isFormData: false,
      isPrivate: true,
    );
  }

  Future<dynamic> getOrders() async {
    final response = await apiHelper.getRequest(
      endPoint: Enpoints.orders,
      isPrivate: true,
    );

    return response.data;
  }

  Future<void> cancelOrder({required int orderId}) async {
    await apiHelper.postRequest(
      endPoint: '${Enpoints.orders}/cancel/$orderId',
      isPrivate: true,
    );
  }

  Future<void> completeOrder({required int orderId}) async {
    await apiHelper.postRequest(
      endPoint: '${Enpoints.orders}/complete/$orderId',
      isPrivate: true,
    );
  }
}
