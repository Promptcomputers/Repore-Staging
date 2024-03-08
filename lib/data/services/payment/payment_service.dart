import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore/lib.dart';

final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService((ref), ref);
});

final dioProvider = Provider(
  (ref) => Dio(
    BaseOptions(
      receiveTimeout: 100000,
      connectTimeout: 100000,
      baseUrl: AppConfig.coreBaseUrl,
    ),
  ),
);

class PaymentService {
  final Ref _read;
  final Ref ref;

  PaymentService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  Future<dynamic> createSetupIntentFromDb() async {
    const url = 'payment/authorize_add_card';

    try {
      final response = await _read.read(dioProvider).post(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return response.data;
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

  Future<List<GetCards>> getCards() async {
    const url = 'payment';

    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );

      final result = getCardsFromJson(response.data['data']);

      return result;
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

  Future<bool> deletedCard(String cardId) async {
    final url = 'payment/$cardId';

    try {
      final response = await _read.read(dioProvider).delete(
            url,
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

  // Future<dynamic> createPaymentIntent() async {
  //   const url = 'payment/setup-intent';
  //   try {
  //     final response = await _read.read(dioProvider).post(
  //           url,
  //           // data: {
  //           //   "amount": amount,
  //           //   "currency": "USD",
  //           // },
  //           // options: Options(
  //           //   headers: {
  //           //     "Authorization":
  //           //         "Bearer sk_test_51NsnPDH3aI1kPWD1Gml2MseAygDnypESJ0Dg9DYiKC6iFHSQKZmjNPgDVZk1R67M3fD4OahVzCvV0fuLOV6f9QBD00pnNcrcLo",
  //           //     "Content-Type": "application/x-www-form-urlencoded",
  //           //   },
  //           // ),
  //         );
  //     return response.data;
  //   } catch (e) {
  //     log('Error $e');
  //     throw Exception(e.toString());
  //   }
  // }
  // Future<dynamic> createPaymentIntent(String amount) async {
  //   const url = 'create-setup-intent';
  //   // const url = 'payment_intents';
  //   try {
  //     final response = await _read.read(dioProvider).post(
  //           url,
  //           data: {
  //             "amount": amount,
  //             "currency": "USD",
  //           },
  //           options: Options(
  //             headers: {
  //               "Authorization":
  //                   "Bearer sk_test_51NsnPDH3aI1kPWD1Gml2MseAygDnypESJ0Dg9DYiKC6iFHSQKZmjNPgDVZk1R67M3fD4OahVzCvV0fuLOV6f9QBD00pnNcrcLo",
  //               "Content-Type": "application/x-www-form-urlencoded",
  //             },
  //           ),
  //         );
  //     return response.data;
  //   } catch (e) {
  //     log('Error $e');
  //     throw Exception(e.toString());
  //   }
  // }
}
