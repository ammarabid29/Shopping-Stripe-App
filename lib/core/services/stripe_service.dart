import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shopping_stripe_app/core/consts/consts.dart';
import 'package:shopping_stripe_app/features/cart/presentation/view_models/cart_view_model.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayments(int amount, WidgetRef ref) async {
    try {
      String? paymentIntentClientSecret =
          await _createPaymentIntent(amount, "usd");
      if (paymentIntentClientSecret == null) return;

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: "Ammar Abid"),
      );

      await _processPayment(ref);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );
      if (response.data != null) {
        return response.data["client_secret"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment(WidgetRef ref) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ref.read(shoppingCartProvider.notifier).clearCart();
      await Stripe.instance.confirmPaymentSheetPayment();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
