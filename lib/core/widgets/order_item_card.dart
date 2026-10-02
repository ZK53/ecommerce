import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/widgets/quantity_stepper.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    this.image = AppImages.womensCasualWear,
    this.name = "Women's Casual Wear",
    this.rating = '4.8',
    this.itemLabel,
    this.price = '\$ 34.00',
    this.oldPrice = '\$ 64.00',
    this.total = '\$ 34.00',
    this.quantity,
    this.onQuantityChanged,
  });

  final String image;
  final String name;
  final String rating;
  final String? itemLabel;
  final String price;
  final String oldPrice;
  final String total;
  final int? quantity;
  final ValueChanged<int>? onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    final showStepper = quantity != null && onQuantityChanged != null;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: AppColors.imageBg,
                  child: Image(
                    image: image.startsWith('http')
                        ? NetworkImage(image)
                        : AssetImage(image),
                    width: 72,
                    height: 84,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 72,
                        height: 84,
                        color: AppColors.imageBg,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Text(
                          rating,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.grey,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                      ],
                    ),

                    if (itemLabel != null) ...[
                      const SizedBox(height: 6),
                      Text(
                        itemLabel!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.grey,
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        if (oldPrice.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            oldPrice,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),

                    if (showStepper) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: QuantityStepper(
                          quantity: quantity!,
                          onChanged: onQuantityChanged!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Divider(color: AppColors.divider, height: 1),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Order (${quantity ?? 1}) :',
                style: const TextStyle(fontSize: 13, color: AppColors.grey),
              ),
              Text(
                total,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
