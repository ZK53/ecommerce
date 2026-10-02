import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';
import 'package:stylish/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:stylish/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:stylish/features/product/presentation/cubit/product_cubit.dart';
import 'package:stylish/features/product/presentation/cubit/product_state.dart';
import 'package:stylish/features/product/presentation/view/product_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.favouriteCubit});

  final FavouriteCubit favouriteCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..getProducts(),
      child: _FavoritesView(favouriteCubit: favouriteCubit),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView({required this.favouriteCubit});

  final FavouriteCubit favouriteCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'My Favorites'),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, productState) {
          if (productState is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (productState is ProductFailure) {
            return Center(child: Text(productState.message));
          }

          if (productState is ProductSuccess) {
            return BlocBuilder<FavouriteCubit, FavouriteState>(
              bloc: favouriteCubit,
              builder: (context, favouriteState) {
                final favorites = productState.products
                    .where((product) => favouriteCubit.isFavorite(product))
                    .toList();

                if (favorites.isEmpty) {
                  return const Center(
                    child: Text(
                      'No favorites yet',
                      style: TextStyle(fontSize: 14, color: AppColors.grey),
                    ),
                  );
                }

                return ProductGrid(
                  children: favorites.map((product) {
                    return ProductCard(
                      // صورة المنتج من الـ API
                      image: product.imagePath,

                      title: product.name,
                      description: product.description,
                      price: '${product.price}',
                      rating: product.rating,

                      isFavorite: favouriteCubit.isFavorite(product),
                      showFavorite: true,

                      onFavoriteTap: () {
                        favouriteCubit.toggleFavourite(product);
                      },

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(
                              product: product,
                              favouriteCubit: favouriteCubit,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
