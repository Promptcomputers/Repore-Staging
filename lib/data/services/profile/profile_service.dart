import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:repore/lib.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService((ref), ref);
});

class ProfileService {
  final Ref _read;
  final Ref ref;

  ProfileService(this._read, this.ref) {
    _read.read(dioProvider).interceptors.addAll(
      [
        ApiInterceptor(),
        ErrorInterceptor(),
        if (kDebugMode) ...[PrettyDioLogger()],
      ],
    );
  }

  ///Get user details
  Future<UserDetailRes> getUserDetails() async {
    // Future<UserDetailRes> getUserDetails(String userId) async {
    final url = 'users';
    // final url = 'users/$userId';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return UserDetailRes.fromJson(response.data);
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

  ///update profile
  Future<bool> updateProfile(
      String userId, UpdateProfileReq updateProfileReq) async {
    final url = 'users/updateprofile/$userId';
    try {
      final response = await _read.read(dioProvider).patch(
            url,
            data: updateProfileReq.toJson(),
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

  ///Get user notifications
  Future<GetNotificationRes> getNotification() async {
    const url = 'notifications';
    try {
      final response = await _read.read(dioProvider).get(
            url,
            options: Options(headers: {"requireToken": true}),
          );
      return GetNotificationRes.fromJson(response.data);
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

// 650a9159f91d8970c0ab43a4
  ///Mark notification as read
  // /api/v1/users/mark-notification
  Future<bool> markNotificationAsRead(String id) async {
    final url = 'notifications/mark-notification';
    try {
      final response = await _read.read(dioProvider).patch(
            url,
            data: {
              'notification': id,
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

  Future<bool> markNotificationAllRead() async {
    final url = 'notifications/mark-all';
    try {
      final response = await _read.read(dioProvider).patch(
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

  ///Set pin
  Future<bool> setPin(String pin) async {
    final url = 'pins/set-pin';
    try {
      final response = await _read.read(dioProvider).patch(
            url,
            data: {"pin": pin},
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
}
