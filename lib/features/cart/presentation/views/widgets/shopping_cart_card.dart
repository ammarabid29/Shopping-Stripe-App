import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_stripe_app/features/cart/presentation/view_models/cart_view_model.dart';
import 'package:shopping_stripe_app/features/products/domain/product_model.dart';

class ShoppingCartCard extends ConsumerWidget {
  const ShoppingCartCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = product.price * product.quantity;

    return Container(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(product.image),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  "Qity: ${product.quantity}",
                ),
                IconButton(
                    onPressed: () {
                      ref
                          .read(shoppingCartProvider.notifier)
                          .addProduct(product);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            Text(
              "\$$totalPrice",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        trailing: IconButton(
          onPressed: () {
            ref.read(shoppingCartProvider.notifier).removeProduct(product);
          },
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
