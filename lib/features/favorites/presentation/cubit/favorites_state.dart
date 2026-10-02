abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {
  final int productId;

  FavouriteLoading(this.productId);
}

class FavouriteSuccess extends FavouriteState {
  final int productId;
  final bool isFavorite;

  FavouriteSuccess({required this.productId, required this.isFavorite});
}

class FavouriteFailure extends FavouriteState {
  final String message;

  FavouriteFailure(this.message);
}
