import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';
import 'package:repore/src/features/ticket/presentation/widget/ticket_loading_state.dart';

class AllTicketTabView extends ConsumerStatefulWidget {
  const AllTicketTabView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllTicketTabViewState();
}

class _AllTicketTabViewState extends ConsumerState<AllTicketTabView> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(searchTicketProvider);

    final int length =
        vm.maybeWhen(data: (v) => v.data!.length, orElse: () => 0);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.homeContainerBorderColor,
            blurRadius: 3.r,
            // spreadRadius: 10.r,
            offset: const Offset(250, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            length == 0
                ? 'Ticket'
                : length == 1
                    ? 'Ticket ($length)'
                    : 'Tickets ($length)',
            // 'Tickets (${vm.asData?.value.data!.length})',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.primaryTextColor,
              16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          YBox(10),
          Expanded(
            child: vm.when(
              data: (value) {
                if (value.data!.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: const Center(
                      child: EmptyNotificationStateWidget(
                        message: 'You don’t have a ticket yet',
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.only(bottom: 100.h),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.data!.length,
                  separatorBuilder: (context, index) => YBox(20.h),
                  itemBuilder: (context, index) {
                    final item = value.data![index];
                    return TicketListBuild(
                      type: item.type == null ? '' : item.type!.name,
                      title: item.subject,
                      subtitle: item.description,
                      status: item.status,
                      titleColor: textColor(item.status),
                      bgColor: ticketBgColor(item.status),
                      statusBgColor: statusBgColor(item.status),
                      statusTextColor: statusTextColor(item.status),
                      onTap: () => context.pushNamed(
                        AppRoute.viewTicketScreen.name,
                        queryParams: {
                          'id': item.id,
                          'ref': item.reference,
                          'title': item.subject,
                        },
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                if (error == HttpErrorStrings.connectionTimeOutActive) {}

                return Text('${error.toString()}');
              },
              loading: () {
                return const TicketLoadingLoadingState();
              },
            ),
          ),
        ],
      ),
    );
  }
}
