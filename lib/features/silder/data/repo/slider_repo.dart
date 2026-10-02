import 'package:stylish/core/newtwork/api_helper.dart';
import 'package:stylish/core/newtwork/enpoints.dart';
import 'package:stylish/features/silder/data/models/slider_model.dart';

class SliderRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<List<SliderModel>> getSliders() async {
    try {
      final response = await apiHelper.getRequest(
        endPoint: Enpoints.sliders,
        isPrivate: true,
      );

      final sliders = response.data['sliders'] as List;

      return sliders.map((slider) => SliderModel.fromJson(slider)).toList();
    } catch (e) {
      throw Exception(apiHelper.handleException(e));
    }
  }
}
