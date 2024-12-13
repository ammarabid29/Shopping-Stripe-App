import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_stripe_app/core/common_features/app_bar.dart';
import 'package:shopping_stripe_app/features/cart/presentation/view_models/cart_view_model.dart';
import 'package:shopping_stripe_app/features/cart/presentation/views/cart_screen.dart';
import 'package:shopping_stripe_app/features/products/data/products.dart';
import 'package:shopping_stripe_app/features/products/presentation/views/widgets/product_card.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductsScreen> {
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
          final isInCart =
              ref.watch(shoppingCartProvider).contains(products[index]);

          return ProductCard(
            image: products[index].image,
            title: products[index].name,
            price: products[index].price,
            addToCart: (isAdded) {
              if (isInCart) {
                ref
                    .read(shoppingCartProvider.notifier)
                    .addProduct(products[index]);
              } else {
                ref
                    .read(shoppingCartProvider.notifier)
                    .removeProduct(products[index]);
              }
            },
            isAdded: isInCart,
          );
        },
      ),
    );
  }
}
