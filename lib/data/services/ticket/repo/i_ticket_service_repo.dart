import 'package:repore/lib.dart';

abstract class ITicketServiceRepo {
  ///Get service type
  Future<ServiceTypeRes> getServiceType();

  ///CREATE A TICKET
  Future<CreateTicketRes> createTicket(
      String subject, String author, String type);
  // ///CREATE A TICKET
  // Future<CreateTicketRes> createTicket(List<File> files, String subject,
  //     String author, String type, String description);

  ///Get user tickets
  Future<GetUserTicketsRes> getUserTicket(String userId, [search = '']);

  ///Get single tickets with fikes
  Future<GetSingleTicketWithFiles> getSingleTicketWithFiles(String userId);

  ///Get ticket messages
  Future<GetTicketMessages> getTicketMessages(String tickeId);

  ///Get ticket messages
  Future<bool> sendTicketMessage(
      String filesPath, String ticketId, String userId, String message);
  // Future<bool> sendTicketMessage(
  //     String message, String userId, String ticketId);

  ///Get all invoice for a ticket
  Future<AllTicketInvoiceRes> getTickeListOfInvoices(String ticketId);

  ///Get invoice details and preview
  Future<InvoiceDetailsRes> getInvoiceDetails(String invoiceId);

  ///update invoice status
  Future<bool> updateInvoiceDetail(String invoiceId, String status,
      String reason, String cardId, String pin);
}
