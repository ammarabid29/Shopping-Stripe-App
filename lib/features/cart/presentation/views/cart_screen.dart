import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_stripe_app/core/common_features/app_bar.dart';
import 'package:shopping_stripe_app/core/services/stripe_service.dart';
import 'package:shopping_stripe_app/features/cart/presentation/view_models/cart_view_model.dart';
import 'package:shopping_stripe_app/features/cart/presentation/views/widgets/shopping_cart_card.dart';
import 'package:shopping_stripe_app/features/products/presentation/views/products_screen.dart';

class ShoppingCartScreen extends ConsumerWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(shoppingCartProvider);

    final totalAmount = cartProducts.fold<int>(
      0,
      (sum, product) => sum + (product.price * product.quantity),
    );

    return Scaffold(
      appBar: AppBarDesign(
        function: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const ProductsScreen(),
            ),
          );
        },
        title: "Shopping Cart",
      ),
      body: cartProducts.isNotEmpty
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 350,
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemExtent: 80,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: 300,
                          child: ShoppingCartCard(
                            product: cartProducts[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Total Amount:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    StripeService.instance.makePayments(totalAmount, ref);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    "Proceed to payment",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text("Nothing to show"),
            ),
    );
  }
}
