import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class PendingTicketTabView extends ConsumerStatefulWidget {
  const PendingTicketTabView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PendingTicketTabViewState();
}

class _PendingTicketTabViewState extends ConsumerState<PendingTicketTabView> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(searchTicketProvider);

    final onGoingList = vm.isLoading
        ? []
        : vm.asData?.value.data!
            .where((element) => element.status == TicketStatusType.CREATED.name)
            .toList();
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
            onGoingList!.isEmpty ? 'Ticket' : 'Tickets (${onGoingList.length})',
            style: AppTextStyle.satoshiFontText(
              context,
              AppColors.primaryTextColor,
              16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          YBox(10),
          onGoingList.isEmpty
              ? Padding(
                  padding: EdgeInsets.only(top: 60.h),
                  child: const Center(
                    child: EmptyNotificationStateWidget(
                      message: 'You don’t have a ticket yet',
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: onGoingList.length,
                    separatorBuilder: (context, index) => YBox(20.h),
                    itemBuilder: (context, index) {
                      final item = onGoingList[index];
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
                  ),
                ),
        ],
      ),
    );
  }
}
