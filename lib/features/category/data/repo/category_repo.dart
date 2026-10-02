import 'package:stylish/core/newtwork/api_helper.dart';
import 'package:stylish/core/newtwork/enpoints.dart';
import 'package:stylish/features/category/data/models/category_model.dart';

class CategoryRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await apiHelper.getRequest(
        endPoint: Enpoints.categories,
        isPrivate: true,
      );

      final categories = response.data['categories'] as List;

      return categories
          .map((category) => CategoryModel.fromJson(category))
          .toList();
    } catch (e) {
      throw Exception(apiHelper.handleException(e));
    }
  }
}
