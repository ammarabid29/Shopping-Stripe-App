import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_stripe_app/features/products/domain/product_model.dart';

final shoppingCartProvider =
    StateNotifierProvider<ShoppingCartNotifier, List<ProductModel>>(
  (ref) {
    return ShoppingCartNotifier();
  },
);

class ShoppingCartNotifier extends StateNotifier<List<ProductModel>> {
  ShoppingCartNotifier() : super([]);

  void addProduct(ProductModel product) {
    final exist = state.any((p) => p.id == product.id);

    if (exist) {
      state = state.map((p) {
        if (p.id == product.id) {
          return ProductModel(
            name: p.name,
            image: p.image,
            price: p.price,
            quantity: p.quantity + 1,
          );
        }
        return p;
      }).toList();
    } else {
      state = [...state, product];
    }
  }

  void removeProduct(ProductModel product) {
    final exist = state.any((p) => p.id == product.id);

    if (exist) {
      state = state
          .map((p) {
            if (p.id == product.id) {
              return p.quantity > 1
                  ? ProductModel(
                      name: p.name,
                      image: p.image,
                      price: p.price,
                      quantity: p.quantity - 1)
                  : null;
            }
            return p;
          })
          .whereType<ProductModel>()
          .toList();
    }
  }

  void clearCart() {
    state = [];
  }
}
