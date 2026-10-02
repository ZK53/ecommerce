import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/widgets/app_search_bar.dart';
import 'package:stylish/core/widgets/category_row.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';
import 'package:stylish/core/widgets/stylish_logo.dart';
import 'package:stylish/features/category/presentation/cubit/category_cubit.dart';
import 'package:stylish/features/category/presentation/cubit/category_state.dart';
import 'package:stylish/features/home/presentation/view/widgets/promo_banner.dart';
import 'package:stylish/features/product/presentation/cubit/product_cubit.dart';
import 'package:stylish/features/product/presentation/cubit/product_state.dart';
import 'package:stylish/features/product/presentation/view/product_details_screen.dart';
import 'package:stylish/features/search/presentation/view/search_screen.dart';
import 'package:stylish/features/silder/presentation/cubit/slider_cubit.dart';
import 'package:stylish/features/silder/presentation/cubit/slider_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCubit()..getProducts()),
        BlocProvider(create: (_) => CategoryCubit()..getCategories()),
        BlocProvider(create: (_) => SliderCubit()..getSliders()),
      ],
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          Center(child: StylishLogo(height: 31, width: 111)),
          const SizedBox(height: 16),
          AppSearchBar(
            readOnly: true,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchScreen()),
            ),
          ),
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
                return CategoryRow(categories: state.categories);
              }

              return const SizedBox();
            },
          ),
          const SizedBox(height: 16),
          BlocBuilder<SliderCubit, SliderState>(
            builder: (context, state) {
              if (state is SliderLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is SliderFailure) {
                return Center(child: Text(state.message));
              }

              if (state is SliderSuccess) {
                return PromoBanner(sliders: state.sliders);
              }

              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          const Text(
            'Recommended',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductFailure) {
                return Center(child: Text(state.message));
              }

              if (state is ProductSuccess) {
                return ProductGrid(
                  shrinkWrap: true,
                  children: state.products.map((product) {
                    return ProductCard(
                      title: product.name,
                      description: product.description,
                      price: '${product.price}',
                      rating: product.rating,
                      isFavorite: product.isFavorite,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductDetailsScreen(),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }

              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
