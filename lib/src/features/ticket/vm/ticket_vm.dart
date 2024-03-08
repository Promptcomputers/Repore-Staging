import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

final getServiceTypeProvider =
    FutureProvider.autoDispose<ServiceTypeRes>((ref) async {
  return await ref.watch(ticketServiceRepoProvider).getServiceType();
});

final createTicketProvider =
    StateNotifierProvider<CreateTicketVm, AsyncValue<CreateTicketRes>>((ref) {
  return CreateTicketVm(ref);
});

class CreateTicketVm extends StateNotifier<AsyncValue<CreateTicketRes>> {
  final Ref ref;
  CreateTicketVm(this.ref) : super(AsyncData(CreateTicketRes()));

  ///Create ticket
  void createTicket(String subject, String author, String type) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(ticketServiceRepoProvider)
          .createTicket(subject, author, type));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

final searchTicketProvider =
    StateNotifierProvider<GetTicketsVM, AsyncValue<GetUserTicketsRes>>((ref) {
  return GetTicketsVM(ref, PreferenceManager.userId);
});
// final searchTicketProvider = StateNotifierProvider.family<GetTicketsVM,
//     AsyncValue<GetUserTicketsRes>, String>((ref, userId) {
//   return GetTicketsVM(ref, userId);
// });

class GetTicketsVM extends StateNotifier<AsyncValue<GetUserTicketsRes>> {
  final Ref ref;
  final String userId;
  GetTicketsVM(this.ref, this.userId) : super(AsyncData(GetUserTicketsRes())) {
    getTicket(userId);
  }

  ///Search ticket
  void getTicket(String userId) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(
          () => ref.read(ticketServiceRepoProvider).getUserTicket(userId));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }

  ///Search ticket
  void searchTicket(String userId, [search = '']) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() =>
          ref.read(ticketServiceRepoProvider).getUserTicket(userId, search));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
}

// final getUserTickets = FutureProvider.autoDispose
//     .family<GetUserTicketsRes, String>((ref, id) async {
//   return await ref.watch(ticketServiceRepoProvider).getUserTicket(id);
// });

final viewSingleTickets = FutureProvider.autoDispose
    .family<GetSingleTicketWithFiles, String>((ref, id) async {
  return await ref
      .watch(ticketServiceRepoProvider)
      .getSingleTicketWithFiles(id);
});

final getTicketMessages = FutureProvider.autoDispose
    .family<GetTicketMessages, String>((ref, ticketId) async {
  return await ref.watch(ticketServiceRepoProvider).getTicketMessages(ticketId);
});

final sendMessageProvider =
    StateNotifierProvider<SendMessageVm, AsyncValue<bool>>((ref) {
  return SendMessageVm(ref);
});

class SendMessageVm extends StateNotifier<AsyncValue<bool>> {
  final Ref ref;
  SendMessageVm(this.ref) : super(const AsyncData(false));

  ///send Message
  void sendMessage(
      String filesPath, String ticketId, String userId, String message) async {
    state = const AsyncValue.loading();
    try {
      state = await AsyncValue.guard(() => ref
          .read(ticketServiceRepoProvider)
          .sendTicketMessage(filesPath, ticketId, userId, message));
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
  // ///send Message
  // void sendMessage(String message, String userId, String ticketId) async {
  //   state = const AsyncValue.loading();
  //   try {
  //     state = await AsyncValue.guard(() => ref
  //         .read(ticketServiceRepoProvider)
  //         .sendTicketMessage(message, userId, ticketId));
  //   } catch (e, s) {
  //     state = AsyncValue.error(e, s);
  //   }
  // }
}
