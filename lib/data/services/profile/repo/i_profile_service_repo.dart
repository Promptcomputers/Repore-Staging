import 'package:repore/lib.dart';

abstract class IProfileServiceRepo {
  ///Get user details
  Future<UserDetailRes> getUserDetails();
  // Future<UserDetailRes> getUserDetails(String userId);

  ///update profile
  Future<bool> updateProfile(String userId, UpdateProfileReq updateProfileReq);

  ///Get user notifications
  Future<GetNotificationRes> getNotification();

  Future<bool> markNotificationAsRead(String id);
  Future<bool> markNotificationAllRead();

  ///Set pin
  Future<bool> setPin(String pin);
}
