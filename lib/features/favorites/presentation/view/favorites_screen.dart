import 'package:flutter/material.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';
import 'package:stylish/features/product/presentation/view/product_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  int _count = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'My Favorites'),
      body: _count == 0
          ? const Center(
              child: Text(
                'No favorites yet',
                style: TextStyle(fontSize: 14, color: AppColors.grey),
              ),
            )
          : ProductGrid(
              children: List.generate(
                _count,
                (_) => ProductCard(
                  showFavorite: true,
                  isFavorite: true,
                  onFavoriteTap: () => setState(() => _count--),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProductDetailsScreen()),
                  ),
                ),
              ),
            ),
    );
  }
}
