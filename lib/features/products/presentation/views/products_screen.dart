import 'package:flutter/material.dart';
import 'package:shopping_stripe_app/core/common_features/app_bar.dart';
import 'package:shopping_stripe_app/features/cart/presentation/views/cart_screen.dart';
import 'package:shopping_stripe_app/features/products/data/products.dart';
import 'package:shopping_stripe_app/features/products/presentation/views/widgets/product_card.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        function: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ShoppingCartScreen(),
            ),
          );
        },
        image: "assets/images/appbarlogo.svg",
      ),
      body: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (ctx, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }
}
