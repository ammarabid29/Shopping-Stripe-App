import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.addToCart,
    required this.isAdded,
  });
  final String image;
  final String title;
  final double price;
  final Function(bool isAdded) addToCart;
  final bool isAdded;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isAdded = false;

  void toggleCart() {
    setState(() {
      isAdded = !isAdded;
    });
    widget.addToCart(isAdded);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          Image.asset(
            widget.image,
            height: 136,
            width: 164,
          ),
          const SizedBox(height: 12),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text("\$${widget.price}"),
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
