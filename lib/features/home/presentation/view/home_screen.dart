import 'package:flutter/material.dart';
import 'package:stylish/core/widgets/app_search_bar.dart';
import 'package:stylish/core/widgets/category_row.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/product_grid.dart';
import 'package:stylish/core/widgets/stylish_logo.dart';
import 'package:stylish/features/home/presentation/view/widgets/promo_banner.dart';
import 'package:stylish/features/product/presentation/view/product_details_screen.dart';
import 'package:stylish/features/search/presentation/view/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
        children: [
           Center(child: StylishLogo(height: 31,width: 111,)),
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
          const CategoryRow(),
          const SizedBox(height: 16),
          const PromoBanner(),
          const SizedBox(height: 20),
          const Text(
            'Recommended',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ProductGrid(
            shrinkWrap: true,
            children: List.generate(
              4,
              (_) => ProductCard(
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
