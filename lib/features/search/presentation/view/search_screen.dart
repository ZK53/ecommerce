import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylish/core/widgets/app_search_bar.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';

import 'package:stylish/features/favorites/presentation/cubit/favorites_cubit.dart';

import 'package:stylish/features/product/presentation/cubit/product_cubit.dart';
import 'package:stylish/features/product/presentation/cubit/product_state.dart';
import 'package:stylish/features/product/presentation/view/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit()..getProducts(),
      child: Scaffold(
        appBar: const DetailAppBar(title: 'Search'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: AppSearchBar(
                controller: _controller,
                onChanged: (_) => setState(() {}),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ProductFailure) {
                    return Center(child: Text(state.message));
                  }

                  if (state is ProductSuccess) {
                    final query = _controller.text.trim().toLowerCase();

                    final results = query.isEmpty
                        ? state.products
                        : state.products.where((product) {
                            return product.name.toLowerCase().contains(query);
                          }).toList();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                          child: Text(
                            '${results.length} Items',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Expanded(
                          child: ProductGrid(
                            children: results.map((product) {
                              return ProductCard(
                                title: product.name,
                                description: product.description,
                                price: '${product.price}',
                                rating: product.rating,

                                isFavorite: context
                                    .watch<FavouriteCubit>()
                                    .isFavorite(product),

                                showFavorite: true,

                                onFavoriteTap: () {
                                  context
                                      .read<FavouriteCubit>()
                                      .toggleFavourite(product);
                                },

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return ProductDetailsScreen(
                                          product: product,
                                          favouriteCubit: context
                                              .read<FavouriteCubit>(),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
