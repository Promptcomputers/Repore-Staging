import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/data/model/res/get_card_res.dart';
import 'package:repore/data/services/payment/payment_service.dart';

import 'i_payment_repo.dart';

final paymentServiceRepoProvider = Provider<PaymentRepo>((ref) {
  final paymentService = ref.watch(paymentServiceProvider);
  return PaymentRepo(paymentService);
});

class PaymentRepo extends IPaymentRepo {
  final PaymentService _paymentService;
  PaymentRepo(this._paymentService);

  @override
  Future createSetupIntentFromDb() async {
    return await _paymentService.createSetupIntentFromDb();
  }

  @override
  Future<bool> deletedCard(String cardId) async {
    return await _paymentService.deletedCard(cardId);
  }

  @override
  Future<List<GetCards>> getCards() async {
    return await _paymentService.getCards();
  }
}
