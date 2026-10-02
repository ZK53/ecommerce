import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/favorites/data/repo/favorites_repo.dart';
import 'package:stylish/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:stylish/features/product/data/models/product_model.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit() : super(FavouriteInitial());

  final FavouriteRepo _repo = FavouriteRepo();

  final Map<int, bool> _favorites = {};

  bool isFavorite(ProductModel product) {
    return _favorites[product.id] ?? product.isFavorite;
  }

  Future<void> toggleFavourite(ProductModel product) async {
    final oldValue = isFavorite(product);
    final newValue = !oldValue;

    emit(FavouriteLoading(product.id));

    try {
      // نفس الـ endpoint بيعمل toggle في الـ API
      await _repo.addToFavourite(productId: product.id);

      _favorites[product.id] = newValue;

      emit(FavouriteSuccess(productId: product.id, isFavorite: newValue));
    } catch (e) {
      emit(FavouriteFailure(e.toString()));
    }
  }
}
