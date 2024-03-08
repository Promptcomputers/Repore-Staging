import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final profileServiceRepoProvider = Provider<ProfileServiceRepo>((ref) {
  final profileService = ref.watch(profileServiceProvider);
  return ProfileServiceRepo(profileService);
});

class ProfileServiceRepo extends IProfileServiceRepo {
  final ProfileService _profileService;
  ProfileServiceRepo(this._profileService);

  @override
  Future<UserDetailRes> getUserDetails() async {
    return await _profileService.getUserDetails();
  }
  // @override
  // Future<UserDetailRes> getUserDetails(String userId) async {
  //   return await _profileService.getUserDetails(userId);
  // }

  @override
  Future<bool> updateProfile(
      String userId, UpdateProfileReq updateProfileReq) async {
    return await _profileService.updateProfile(userId, updateProfileReq);
  }

  @override
  Future<GetNotificationRes> getNotification() async {
    return await _profileService.getNotification();
  }

  @override
  Future<bool> markNotificationAsRead(String id) async {
    return await _profileService.markNotificationAsRead(id);
  }

  @override
  Future<bool> markNotificationAllRead() async {
    return await _profileService.markNotificationAllRead();
  }

  @override
  Future<bool> setPin(String pin) async {
    return await _profileService.setPin(pin);
  }
}
