import 'package:flutter/material.dart';
import 'package:shopping_stripe_app/core/common_features/app_bar.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        function: () {},
        title: "Shopping Cart",
      ),
    );
  }
}
