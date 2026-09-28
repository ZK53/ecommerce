import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/widgets/app_svg.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.image = AppImages.shirt,
    this.title = 'Mens Starry',
    this.description = 'Mens Starry Sky Printed Shirt 100% Cotton Fabric',
    this.price = '₹399',
    this.rating = 4.5,
    this.reviews = '1,52,344',
    this.showFavorite = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  final String image;
  final String title;
  final String description;
  final String price;
  final double rating;
  final String reviews;
  final bool showFavorite;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: AppShadows.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: AppColors.imageBg,
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                    if (showFavorite)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: FavoriteButton(
                          isFavorite: isFavorite,
                          onTap: onFavoriteTap,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 10,fontWeight: FontWeight.w400, color: AppColors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      StarRating(rating: rating),
                      const SizedBox(width: 4),
                      Text(
                        reviews,
                        style: const TextStyle(fontSize: 10,fontWeight: FontWeight.w400, color: AppColors.lightGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.isFavorite, this.onTap, this.size = 26});

  final bool isFavorite;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppSvg(
            isFavorite ? AppIcons.heartFilled : AppIcons.heart,
            size: size * 0.55,
            color: isFavorite ? AppColors.primary : AppColors.grey,
          ),
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.rating, this.size = 12});

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final icon = rating >= i + 1
            ? Icons.star
            : (rating >= i + 0.5 ? Icons.star_half : Icons.star_border);
        return Icon(icon, size: size, color: AppColors.star);
      }),
    );
  }
}
