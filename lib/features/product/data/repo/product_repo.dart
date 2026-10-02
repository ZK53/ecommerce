import 'package:stylish/core/newtwork/api_helper.dart';
import 'package:stylish/core/newtwork/enpoints.dart';
import 'package:stylish/features/product/data/models/product_model.dart';

class ProductRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiHelper.getRequest(
        endPoint: Enpoints.products,
        isPrivate: true,
      );

      final products = response.data['products'] as List;

      return products.map((product) => ProductModel.fromJson(product)).toList();
    } catch (e) {
      throw Exception(apiHelper.handleException(e));
    }
  }
}
