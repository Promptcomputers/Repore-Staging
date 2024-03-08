import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final getAallInvoiceTicketProvider = FutureProvider.autoDispose
    .family<AllTicketInvoiceRes, String>((ref, ticketId) async {
  return await ref
      .watch(ticketServiceRepoProvider)
      .getTickeListOfInvoices(ticketId);
});
