import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final getUserDetailsProvider =
    FutureProvider.autoDispose<UserDetailRes>((ref) async {
  return await ref.watch(profileServiceRepoProvider).getUserDetails();
  // return await ref
  //     .watch(profileServiceRepoProvider)
  //     .getUserDetails(PreferenceManager.userId);
});

final updateProfileProvider =
    StateNotifierProvider<UpdateProfileVm, AsyncValue<bool>>((ref) {
  return UpdateProfileVm(ref);
});

class UpdateProfileVm extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  UpdateProfileVm(this.ref) : super(const AsyncData(false));

  ///updateProfile
  void updateProfile(UpdateProfileReq updateProfileReq, String userId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(profileServiceRepoProvider)
          .updateProfile(userId, updateProfileReq));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
