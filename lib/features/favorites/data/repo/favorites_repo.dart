import 'package:stylish/core/newtwork/api_helper.dart';
import 'package:stylish/core/newtwork/enpoints.dart';

class FavouriteRepo {
  final ApiHelper apiHelper = ApiHelper();

  Future<void> addToFavourite({required int productId}) async {
    await apiHelper.postRequest(
      endPoint: Enpoints.addToFavourites,
      data: {'product_id': productId},
      isPrivate: true,
    );
  }
}
