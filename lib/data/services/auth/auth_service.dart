import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore/lib.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService((ref), ref);
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

class AuthService {
  final Ref _read;
  final Ref ref;

  AuthService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Register
  Future<bool> register(RegisterReq registerReq) async {
    const url = 'auth/register';
    try {
      final response = await _read.read(dioProvider).post(
            url,
            data: registerReq.toJson(),
          );
      return response.data = true;
    } on DioError catch (e) {
      if (e.response != null && e.response!.data != '') {
        throw e.error;
        // FailureModelRes failureModelRes =
        //     FailureModelRes.fromJson(e.response!.data);
        // throw failureModelRes.errors[0].message;
        // throw failureModelRes;
      } else {
        log(e.error);
        throw e.error;
      }
    }
  }

  ///Login
  Future<LoginRes> login(
      {required String email,
      required String password,
      required String deviceToken}) async {
    const url = 'auth/login';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          "email": email,
          "password": password,
          "device_token": deviceToken,
        },
      );
      return LoginRes.fromJson(response.data);
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

  ///Change password for logged in user
  Future<bool> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String userId}) async {
    final url = 'users/changepassword/$userId';
    try {
      final response = await _read.read(dioProvider).patch(
            url,
            data: {
              "oldpassword": oldPassword,
              "password": newPassword,
            },
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

  ///Send Otp to user
  // Future<SendOtpRes> forgotPasswordOtpCode({required String email}) async {
  Future<bool> forgotPasswordOtpCode({required String email}) async {
    const url = 'auth/forgotpassword';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          "email": email,
        },
        // options: Options(headers: {"requireToken": true}),
      );
      return response.data == true;
      // return SendOtpRes.fromJson(response.data);
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

  ///Verify the Otp  sent to the user
  Future<bool> verifiyOtpCode(
      {required String email,
      required String userId,
      required String otpCode}) async {
    const url = 'auth/verify-otp';
    try {
      final response = await _read.read(dioProvider).post(
        url,
        data: {
          "email": email,
          "id": userId,
          "otp": otpCode,
        },
        // options: Options(headers: {"requireToken": true}),
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

  // /Change password for logged in user
  Future<bool> forgotChangePassword(
      {required String newPassword, required String userId}) async {
    const url = 'auth/changepassword';
    try {
      final response = await _read.read(dioProvider).patch(
        url,
        data: {
          "password": newPassword,
          "id": userId,
        },
        // options: Options(headers: {"requireToken": true}),
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
}
