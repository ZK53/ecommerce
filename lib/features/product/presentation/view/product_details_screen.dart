import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/constants/image_assets.dart';

import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/app_svg.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/widgets/detail_app_bar.dart';
import 'package:stylish/core/widgets/product_card.dart';
import 'package:stylish/core/widgets/quantity_stepper.dart';

import 'package:stylish/features/favorites/presentation/cubit/favorites_cubit.dart';
import 'package:stylish/features/favorites/presentation/cubit/favorites_state.dart';
import 'package:stylish/features/product/data/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.favouriteCubit,
  });

  final ProductModel product;
  final FavouriteCubit favouriteCubit;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DetailAppBar(title: 'Product'),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          AspectRatio(
            aspectRatio: 1.05,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    color: AppColors.imageBg,
                    child: Image.network(
                      widget.product.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      bloc: widget.favouriteCubit,
                      builder: (context, state) {
                        return FavoriteButton(
                          isFavorite: widget.favouriteCubit.isFavorite(
                            widget.product,
                          ),
                          size: 30,
                          onTap: () {
                            widget.favouriteCubit.toggleFavourite(
                              widget.product,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            widget.product.description,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.product.price} \$',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              QuantityStepper(
                quantity: _quantity,
                onChanged: (v) {
                  setState(() {
                    _quantity = v;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 28),
          CustomButton(
            text: 'Add To Cart',
            icon: const AppSvg(AppIcons.cart, size: 18, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added $_quantity item(s) to cart')),
              );
            },
          ),
        ],
      ),
    );
  }
}
