import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_stripe_app/features/cart/presentation/view_models/cart_view_model.dart';
import 'package:shopping_stripe_app/features/products/domain/product_model.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(shoppingCartProvider);
    final isAdded = cartProducts.any((p) => p.id == product.id);

    void toggleCart() {
      if (isAdded) {
        ref.read(shoppingCartProvider.notifier).removeProduct(product);
      } else {
        ref.read(shoppingCartProvider.notifier).addProduct(product);
      }
    }

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(
            product.image,
            height: 136,
            width: 164,
          ),
          const SizedBox(height: 12),
          Text(
            product.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text("\$${product.price}"),
          ElevatedButton.icon(
            onPressed: toggleCart,
            icon: Icon(isAdded ? Icons.check : Icons.add_shopping_cart),
            label: Text(isAdded ? "Added" : "Add to cart"),
          ),
        ],
      ),
    );
  }
}
