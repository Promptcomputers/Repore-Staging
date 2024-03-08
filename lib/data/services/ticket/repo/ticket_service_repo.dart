import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final ticketServiceRepoProvider = Provider<TicketServiceRepo>((ref) {
  final ticketService = ref.watch(ticketServiceProvider);
  return TicketServiceRepo(ticketService);
});

class TicketServiceRepo extends ITicketServiceRepo {
  final TicketService _ticketService;
  TicketServiceRepo(this._ticketService);

  @override
  Future<CreateTicketRes> createTicket(
      String subject, String author, String type) async {
    return await _ticketService.createTicket(subject, author, type);
  }
  // @override
  // Future<CreateTicketRes> createTicket(List<File> files, String subject,
  //     String author, String type, String description) async {
  //   return await _ticketService.createTicket(
  //       files, subject, author, type, description);
  // }

  @override
  Future<GetSingleTicketWithFiles> getSingleTicketWithFiles(
      String userId) async {
    return await _ticketService.getSingleTicketWithFiles(userId);
  }

  @override
  Future<ServiceTypeRes> getServiceType() async {
    return await _ticketService.getServiceType();
  }

  @override
  Future<GetUserTicketsRes> getUserTicket(String userId, [search = '']) async {
    return await _ticketService.getUserTicket(userId, search);
  }

  @override
  Future<GetTicketMessages> getTicketMessages(String tickeId) async {
    return await _ticketService.getTicketMessages(tickeId);
  }

  @override
  Future<bool> sendTicketMessage(
      String filesPath, String ticketId, String userId, String message) async {
    return await _ticketService.sendTicketMessage(
        filesPath, ticketId, userId, message);
  }

  @override
  Future<InvoiceDetailsRes> getInvoiceDetails(String invoiceId) async {
    return await _ticketService.getInvoiceDetails(invoiceId);
  }

  @override
  Future<AllTicketInvoiceRes> getTickeListOfInvoices(String ticketId) async {
    return await _ticketService.getTickeListOfInvoices(ticketId);
  }

  @override
  Future<bool> updateInvoiceDetail(String invoiceId, String status,
      String reason, String cardId, String pin) async {
    return await _ticketService.updateInvoiceDetail(
        invoiceId, status, reason, cardId, pin);
  }
  // @override
  // Future<bool> sendTicketMessage(
  //     String message, String userId, String ticketId) async {
  //   return await _ticketService.sendTicketMessage(message, userId, ticketId);
  // }
}
