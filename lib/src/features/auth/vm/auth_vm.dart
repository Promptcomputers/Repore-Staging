import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final registerProvider =
    StateNotifierProvider<RegisterVM, AsyncValue<bool>>((ref) {
  return RegisterVM(ref);
});

class RegisterVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  RegisterVM(this.ref) : super(const AsyncData(false));

  ///Register
  void register(RegisterReq registerReq) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(authServiceRepoProvider).register(registerReq));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final loginProvider =
    StateNotifierProvider<LoginVM, AsyncValue<LoginRes>>((ref) {
  return LoginVM(ref);
});

class LoginVM extends StateNotifier<AsyncValue<LoginRes>> {
  final Ref ref;
  LoginVM(this.ref) : super(AsyncData(LoginRes()));

  void login(email, password) async {
    final messaging = FirebaseMessaging.instance;
    final deviceId = await messaging.getToken();
    // log('DeviceToken $deviceId');
    state = const AsyncValue.loading();
    try {
      // state = await AsyncValue.guard(() => ref
      //     .read(authServiceRepoProvider)
      //     .login(email: email, password: password, deviceToken: ''));
      state = await AsyncValue.guard(() => ref
          .read(authServiceRepoProvider)
          .login(email: email, password: password, deviceToken: deviceId!));
      if (!state.hasError) {
        PreferenceManager.isFirstLaunch = false;
        PreferenceManager.isloggedIn = true;
        PreferenceManager.token = state.asData!.value.data!.token;
        PreferenceManager.deviceToken = deviceId!;
        // ref
        //     .read(userProvider)
        //     .setFirstName(state.asData!.value.data!.firstname!);
        // ref.read(userProvider).setUserId(state.asData!.value.data!.id!);
        PreferenceManager.userId = state.asData!.value.data!.user.id;
        PreferenceManager.firstName = state.asData!.value.data!.user.firstname;

        PreferenceManager.email = state.asData!.value.data!.user.email;
      }
    } catch (e, s) {
      log('error from loginvm $e');
      state = AsyncValue.error(e, s);
    }
  }
}

final changePasswordProvider =
    StateNotifierProvider<ChangePasswordVM, AsyncValue<bool>>((ref) {
  return ChangePasswordVM(ref);
});

class ChangePasswordVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  ChangePasswordVM(this.ref) : super(const AsyncData(false));

  ///Change password fo rlogged in user
  void changePassword(oldPassword, newPassword, userId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(authServiceRepoProvider)
          .changePassword(
              oldPassword: oldPassword,
              newPassword: newPassword,
              userId: userId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final forgotPasswordOtpProvider =
    StateNotifierProvider.autoDispose<ForgotPasswordOtpVM, AsyncValue<bool>>(
        (ref) {
  return ForgotPasswordOtpVM(ref);
});

class ForgotPasswordOtpVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  ForgotPasswordOtpVM(this.ref) : super(AsyncData(false));

  ///Send otp to user
  void forgotPasswordOtp(email) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(authServiceRepoProvider)
          .forgotPasswordOtpCode(email: email));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final verifyOtpProvider =
    StateNotifierProvider<VerifyOtpVM, AsyncValue<bool>>((ref) {
  return VerifyOtpVM(ref);
});

class VerifyOtpVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  VerifyOtpVM(this.ref) : super(const AsyncData(false));

  ///Send otp to user
  void verifyOtp(
      {required String email,
      required String userId,
      required String otpCode}) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(authServiceRepoProvider)
          .verifiyOtpCode(email: email, userId: userId, otpCode: otpCode));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final changeForgotPasswordProvider =
    StateNotifierProvider<ChangeForgotPasswordVM, AsyncValue<bool>>((ref) {
  return ChangeForgotPasswordVM(ref);
});

class ChangeForgotPasswordVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  ChangeForgotPasswordVM(this.ref) : super(const AsyncData(false));

  ///Send otp to user
  void forgotChangePassword(
      {required String newPassword, required String userId}) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(authServiceRepoProvider)
          .forgotChangePassword(newPassword: newPassword, userId: userId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
