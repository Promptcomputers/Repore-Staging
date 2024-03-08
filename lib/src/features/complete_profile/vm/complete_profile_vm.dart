import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final createPinProvider =
    StateNotifierProvider<CrearePinVM, AsyncValue<bool>>((ref) {
  return CrearePinVM(ref);
});

class CrearePinVM extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  CrearePinVM(this.ref) : super(const AsyncData(false));

  ///Create pin
  void createPin(String pin) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(profileServiceRepoProvider).setPin(pin));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}
