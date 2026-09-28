import 'package:flutter/material.dart';
import 'package:stylish/core/widgets/category_row.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';
import 'package:stylish/core/widgets/stylish_logo.dart';
import 'package:stylish/features/product/view/product_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  static const _count = 6;

  int _category = 0;
  final List<bool> _favorites = List.filled(_count, false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
          const Center(child: StylishLogo(height:31 ,width: 111,)),
          const SizedBox(height: 20),
          const Text(
            'All Featured',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          CategoryRow(
            selectedIndex: _category,
            onChanged: (i) => setState(() => _category = i),
          ),
          const SizedBox(height: 16),
          const Text(
            'Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ProductGrid(
            shrinkWrap: true,
            children: List.generate(
              _count,
              (i) => ProductCard(
                showFavorite: true,
                isFavorite: _favorites[i],
                onFavoriteTap: () => setState(() => _favorites[i] = !_favorites[i]),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProductDetailsScreen()),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
