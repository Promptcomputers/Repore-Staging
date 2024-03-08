import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/data/services/payment/repo/payment_repo.dart';
import 'package:repore/lib.dart';

final stripeProvider =
    StateNotifierProvider<StripeVM, AsyncValue<dynamic>>((ref) {
  return StripeVM(ref);
});

class StripeVM extends StateNotifier<AsyncValue<dynamic>> {
  final Ref ref;
  StripeVM(this.ref) : super(AsyncData(false));
  void createSetupIntentFromDb() async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(paymentServiceRepoProvider).createSetupIntentFromDb());
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final confirmSetupIntentProvider =
    StateNotifierProvider<ConfirmSetupIntentVM, AsyncValue<dynamic>>((ref) {
  return ConfirmSetupIntentVM(ref);
});

class ConfirmSetupIntentVM extends StateNotifier<AsyncValue<dynamic>> {
  final Ref ref;
  ConfirmSetupIntentVM(this.ref) : super(AsyncData(false));
  // Future<void> _handleSavePress() async {
  Future<bool> handleSavePress(
      BuildContext context, String paymentIntentClientSecret) async {
    try {
      final billingDetails = BillingDetails(
        name: "${PreferenceManager.firstName} ${PreferenceManager.lastName}",
        email: PreferenceManager.email,
      );

      // 3. Confirm setup intent

      await Stripe.instance.confirmSetupIntent(
        paymentIntentClientSecret: paymentIntentClientSecret,
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: billingDetails,
          ),
        ),
      );

      return true;
    } catch (error) {
      log('AN error occure in validating setup inytent $error');
      return false;
    }
  }
}
