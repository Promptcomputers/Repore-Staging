import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore/lib.dart';

final ticketServiceProvider = Provider<TicketService>((ref) {
  return TicketService((ref), ref);
});

class TicketService {
  final Ref _read;
  final Ref ref;

  TicketService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Get service type
  Future<ServiceTypeRes> getServiceType() async {
    const url = 'types';
    try {
      final response = await _read.read(dioProvider).get(
            url,
          );
      return ServiceTypeRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///CREATE A TICKET
  Future<CreateTicketRes> createTicket(
      String subject, String author, String type) async {
    const url = 'tickets/create';

    // FormData formData = FormData.fromMap({
    //   "subject": subject,
    //   "author": author,
    //   "type": type,
    // });

    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: {
              "subject": subject,
              "author": author,
              "type": type,
            },
            // data: formData,
            options: Options(headers: {"requireToken": true}),
          );

      return CreateTicketRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != "") {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureResult.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }
  // ///CREATE A TICKET
  // Future<CreateTicketRes> createTicket(List<File> files, String subject,
  //     String author, String type, String description) async {
  //   const url = 'tickets/create';
  //   List<MultipartFile> fileList = [];
  //   for (int i = 0; i < files.length; i++) {
  //     fileList.add(
  //       await MultipartFile.fromFile(
  //         files[i].path,
  //         filename: files[i].path.split('/').last,
  //         // contentType: MediaType('png', 'doc'),
  //         contentType: MediaType('image', 'jpeg'),
  //       ),
  //     );
  //   }

  //   FormData formData = FormData.fromMap({
  //     "files": fileList,
  //     // "files": [
  //     //   for (var e in files) await MultipartFile.fromFile(e.path),
  //     // ],
  //     "subject": subject,
  //     "author": author,
  //     "type": type,
  //     "description": description,
  //   });
  //   log(' data : ${formData.fields}');
  //   log('files: ${formData.fields[0]}');
  //   log('lenght${formData.fields.length}');
  //   try {
  //     final response = await _read.read(dioProvider).post(
  //           url,
  //           data: formData,
  //           options: Options(headers: {"requireToken": true}),
  //         );

  //     return CreateTicketRes.fromJson(response.data);
  //   } on DioError catch (e) {
  //     if (e.response != null && e.response!.data != "") {
  //       FailureModelRes failureResult =
  //           FailureModelRes.fromJson(e.response!.data);
  //       throw failureResult.message;
  //     } else {
  //       log(e.error);
  //       throw e.error;
  //     }
  //   }
  // }

  ///Get user tickets
  Future<GetUserTicketsRes> getUserTicket(String userId, [search = '']) async {
    final url = 'tickets/customer/$userId';
    var queryParameters = {
      "search": search,
    };
    try {
      final response = await _read.read(dioProvider).get(
            url,
            queryParameters: queryParameters,
            options: Options(headers: {"requireToken": true}),
          );
      return GetUserTicketsRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get single tickets with fikes
  Future<GetSingleTicketWithFiles> getSingleTicketWithFiles(
      String userId) async {
    final url = 'tickets/$userId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetSingleTicketWithFiles.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get ticket messages
  Future<GetTicketMessages> getTicketMessages(String tickeId) async {
    final url = 'messages/$tickeId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetTicketMessages.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get ticket messages
  Future<bool> sendTicketMessage(
      String filesPath, String ticketId, String userId, String message) async {
    File file = File(filesPath);
    final mimeTypeData =
        lookupMimeType(file.path, headerBytes: [0xFF, 0xD8])!.split('/');
    const url = 'messages/create-message';

    FormData formData = FormData.fromMap({
      // "files": await MultipartFile.fromFile(file.path,
      //     contentType: MediaType(mimeTypeData[0], mimeTypeData[1])),

      "files": filesPath.isNotEmpty
          ? await MultipartFile.fromFile(file.path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
          : "",
      "ticket": ticketId,
      "from": userId,
      "message": message,
    });

    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: formData,
            // data: {
            //   "message": message,
            //   "from": userId,
            //   "ticket": ticketId,
            // },
            options: Options(headers: {"requireToken": true}),
          );
      return response.data = true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get all invoice for a ticket
  Future<AllTicketInvoiceRes> getTickeListOfInvoices(String ticketId) async {
    final url = 'invoice/all/$ticketId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return AllTicketInvoiceRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Get invoice details and preview
  Future<InvoiceDetailsRes> getInvoiceDetails(String invoiceId) async {
    final url = 'invoice/$invoiceId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return InvoiceDetailsRes.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///update invoice status
  Future<bool> updateInvoiceDetail(String invoiceId, String status,
      String reason, String cardId, String pin) async {
    final url = 'invoice/$invoiceId';
    try {
      final response = await _read.read(dioProvider).patch(
            url,
            data: {
              "status": status,

              ///for reject
              "reason": reason,

              ///for reject
              "card": cardId,

              ///for accept
              ///pin
              "pin": pin,
            },
            options: Options(headers: {"requireToken": true}),
          );
      return response.data == true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes.message;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }
}
