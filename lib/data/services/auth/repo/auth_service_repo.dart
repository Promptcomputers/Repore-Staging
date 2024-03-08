import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final authServiceRepoProvider = Provider<AuthServiceRepo>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthServiceRepo(authService);
});

class AuthServiceRepo extends IAUthServiceRepo {
  final AuthService _authService;
  AuthServiceRepo(this._authService);

  @override
  Future<bool> register(RegisterReq registerReq) async {
    return await _authService.register(registerReq);
  }

  @override
  Future<LoginRes> login(
      {required String email,
      required String password,
      required String deviceToken}) async {
    return await _authService.login(
        email: email, password: password, deviceToken: deviceToken);
  }

  @override
  Future<bool> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String userId}) async {
    return await _authService.changePassword(
        oldPassword: oldPassword, newPassword: newPassword, userId: userId);
  }

  @override

  ///Send Otp to user
  // Future<SendOtpRes> forgotPasswordOtpCode({required String email}) async {
  Future<bool> forgotPasswordOtpCode({required String email}) async {
    return await _authService.forgotPasswordOtpCode(email: email);
  }

  @override
  Future<bool> forgotChangePassword(
      {required String newPassword, required String userId}) async {
    return await _authService.forgotChangePassword(
        newPassword: newPassword, userId: userId);
  }

  @override
  Future<bool> verifiyOtpCode(
      {required String email,
      required String userId,
      required String otpCode}) async {
    return await _authService.verifiyOtpCode(
        email: email, userId: userId, otpCode: otpCode);
  }
}
