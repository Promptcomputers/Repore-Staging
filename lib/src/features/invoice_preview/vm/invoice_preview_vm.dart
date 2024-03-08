import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final viewInvoiceProvider = FutureProvider.autoDispose
    .family<InvoiceDetailsRes, String>((ref, invoiceId) async {
  return await ref
      .watch(ticketServiceRepoProvider)
      .getInvoiceDetails(invoiceId);
});

final updateInvoiceStatus =
    StateNotifierProvider<UpdateInvoiceStatusVm, AsyncValue<dynamic>>((ref) {
  return UpdateInvoiceStatusVm(ref);
});

class UpdateInvoiceStatusVm extends StateNotifier<AsyncValue<dynamic>> {
  final Ref ref;
  UpdateInvoiceStatusVm(this.ref) : super(const AsyncData(true));

  ///Create ticket
  void updateInvoiceStatus(String invoiceId, String status, String reason,
      String cardId, String pin) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(ticketServiceRepoProvider)
          .updateInvoiceDetail(invoiceId, status, reason, cardId, pin));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
