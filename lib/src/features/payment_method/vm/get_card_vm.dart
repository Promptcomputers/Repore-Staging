import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/data/services/payment/repo/payment_repo.dart';
import 'package:repore/lib.dart';

final getCardsProvider =
    FutureProvider.autoDispose<List<GetCards>>((ref) async {
  return await ref.watch(paymentServiceRepoProvider).getCards();
});

final deleteCardProvider =
    StateNotifierProvider<DeleteCardVM, AsyncValue<bool>>((ref) {
  return DeleteCardVM(ref);
});

class DeleteCardVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  DeleteCardVM(this.ref) : super(const AsyncData(false));

  ///Delete card
  void deleteCard(String cardId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(paymentServiceRepoProvider).deletedCard(cardId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
