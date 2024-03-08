import 'package:repore/data/model/req/register_req.dart';
import 'package:repore/data/model/res/login_res.dart';

abstract class IAUthServiceRepo {
  ///Register
  Future<bool> register(RegisterReq registerReq);

  ///Login
  Future<LoginRes> login(
      {required String email,
      required String password,
      required String deviceToken});

  ///Change password for logged in user
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String userId,
  });

  ///Send Otp to user
  Future<bool> forgotPasswordOtpCode({required String email});
  // Future<SendOtpRes> forgotPasswordOtpCode({required String email});

  ///Verify the Otp  sent to the user
  Future<bool> verifiyOtpCode(
      {required String email, required String userId, required String otpCode});

  // /Change password for logged in user
  Future<bool> forgotChangePassword(
      {required String newPassword, required String userId});
}
