import 'package:flutter/material.dart';
import 'package:stylish/core/constants/image_assets.dart';
import 'package:stylish/core/theme/app_colors.dart';
import 'package:stylish/core/theme/app_theme.dart';
import 'package:stylish/core/widgets/quantity_stepper.dart';

/// كارت منتج جوه Cart / Checkout / Order Details.
/// لو بعتّ quantity و onQuantityChanged بيظهر الـ stepper.
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: AppShadows.card,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(image, width: 72, height: 84, fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(rating, style: const TextStyle(fontSize: 10)),
                        const SizedBox(width: 2),
                        const Icon(Icons.star, size: 11, color: AppColors.star),
                      ],
                    ),
                    if (itemLabel != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          itemLabel!,
                          style: const TextStyle(fontSize: 10, color: AppColors.grey),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          price,
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          oldPrice,
                          style: const TextStyle(
                            fontSize: 9,
                            color: AppColors.lightGrey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    if (showStepper)
                      Align(
                        alignment: Alignment.centerRight,
                        child: QuantityStepper(
                          quantity: quantity!,
                          onChanged: onQuantityChanged!,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Order (${quantity ?? 1}) :',
                style: const TextStyle(fontSize: 10),
              ),
              Text(
                total,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
