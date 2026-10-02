import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/core/widgets/category_row.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';
import 'package:stylish/core/widgets/stylish_logo.dart';

import 'package:stylish/features/category/presentation/cubit/category_cubit.dart';
import 'package:stylish/features/category/presentation/cubit/category_state.dart';

import 'package:stylish/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:stylish/features/favorites/presentation/cubit/favorites_state.dart';

import 'package:stylish/features/product/presentation/cubit/product_cubit.dart';
import 'package:stylish/features/product/presentation/cubit/product_state.dart';
import 'package:stylish/features/product/presentation/view/product_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int? _categoryId;

  @override
  Widget build(BuildContext context) {
    final favouriteCubit = context.read<FavouriteCubit>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()..getProducts()),
        BlocProvider(create: (_) => CategoryCubit()..getCategories()),
      ],
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            const Center(child: StylishLogo(height: 31, width: 111)),

            const SizedBox(height: 20),

            const Text(
              'All Featured',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CategoryFailure) {
                  return Center(child: Text(state.message));
                }

                if (state is CategorySuccess) {
                  return CategoryRow(
                    categories: state.categories,
                    selectedIndex: state.categories.indexWhere(
                      (category) => category.id == _categoryId,
                    ),
                    onChanged: (index) {
                      setState(() {
                        _categoryId = state.categories[index].id;
                      });
                    },
                  );
                }

                return const SizedBox();
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Products',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 12),

            BlocBuilder<ProductCubit, ProductState>(
              builder: (context, productState) {
                if (productState is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (productState is ProductFailure) {
                  return Center(child: Text(productState.message));
                }

                if (productState is ProductSuccess) {
                  final products = _categoryId == null
                      ? productState.products
                      : productState.products
                            .where(
                              (product) => product.categoryId == _categoryId,
                            )
                            .toList();

                  return BlocBuilder<FavouriteCubit, FavouriteState>(
                    bloc: favouriteCubit,
                    builder: (context, favouriteState) {
                      return ProductGrid(
                        shrinkWrap: true,
                        children: List.generate(products.length, (i) {
                          final product = products[i];

                          return ProductCard(
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
                                  builder: (_) {
                                    return ProductDetailsScreen(
                                      product: product,
                                      favouriteCubit: favouriteCubit,
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        }),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
