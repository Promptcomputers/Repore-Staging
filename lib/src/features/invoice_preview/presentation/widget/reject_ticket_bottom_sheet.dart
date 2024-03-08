import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore/lib.dart';

class RejectInvoiceBottomSheet extends ConsumerStatefulWidget {
  final String invoiceId;
  const RejectInvoiceBottomSheet({required this.invoiceId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RejectInvoiceBottomSheetState();
}

class _RejectInvoiceBottomSheetState
    extends ConsumerState<RejectInvoiceBottomSheet> {
  List<ReasonItem> reasonItems = [
    ReasonItem(reason: 'Offer is too high'),
    ReasonItem(reason: 'Offer is to low'),
    ReasonItem(reason: 'Workload too much'),
    // Add more items as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      for (var item in reasonItems) {
        item.isSelected = false;
      }
      reasonItems[index].isSelected = true;
    });
  }

  String reason = '';

  @override
  Widget build(BuildContext context) {
    //TODO: The margin is not refelecitng
    final vm = ref.watch(updateInvoiceStatus);
    ref.listen<AsyncValue>(updateInvoiceStatus, (T, value) {
      if (value.hasValue) {
        Navigator.of(context).pop();
        ref.invalidate(viewInvoiceProvider(widget.invoiceId));
        ref.invalidate(getAallInvoiceTicketProvider('widget.invoiceId'));
      }
      if (value.hasError) {
        Navigator.of(context).pop();
      }
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding:
              EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h, bottom: 60.h),
          margin: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                AppIcon.rejectInvoiceIcon,
              ),
              YBox(10),
              Text(
                'Reject Invoice',
                style: AppTextStyle.josefinSansFont(
                  context,
                  AppColors.notificationHeaderColor,
                  14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              YBox(10),
              Text(
                'An email will be sent to Repore team about this action.',
                style: AppTextStyle.satoshiFontText(
                  context,
                  AppColors.headerTextColor1,
                  12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemCount: reasonItems.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text(
                      reasonItems[index].reason,
                      style: AppTextStyle.satoshiFontText(
                        context,
                        AppColors.primaryTextColor,
                        12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: reasonItems[index].isSelected
                        ? const Icon(
                            Icons.check_box_outlined,
                            color: AppColors.primaryColor,
                          )
                        : const Icon(Icons.check_box_outline_blank),
                    onTap: () {
                      _onItemTapped(index);
                      setState(() {
                        reason = reasonItems[index].reason;
                      });
                      log('reason $reason');
                    },
                  );
                },
              ),
              // YBox(10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Other reason',
              //       style: AppTextStyle.satoshiFontText(
              //         context,
              //         AppColors.primaryTextColor,
              //         12.sp,
              //         fontWeight: FontWeight.w400,
              //       ),
              //     ),
              //     Image.asset(AppIcon.forwardArrowIcon)
              //   ],
              // ),
              YBox(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 140.w,
                    child: AppButton(
                      buttonText: 'Close',
                      onPressed: () {
                        Navigator.pop(context);
                        // context.pop();
                      },
                      bgColor: AppColors.headerTextColor1.withOpacity(0.1),
                      textColor: AppColors.primaryTextColor,
                      borderColor: AppColors.headerTextColor1.withOpacity(0.1),
                    ),
                  ),
                  XBox(10),
                  SizedBox(
                    width: 140.w,
                    child: AppButton(
                      buttonText: 'Reject',
                      bgColor: AppColors.redColor,
                      borderColor: AppColors.redColor,
                      textColor: AppColors.whiteColor,
                      isLoading: vm.isLoading,
                      onPressed: () {
                        showModalBottomSheet(
                          // backgroundColor: Colors.transparent,
                          barrierColor:
                              AppColors.primaryTextColor.withOpacity(1.0),
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.vertical(
                          //     top: Radius.circular(20.0.sp),
                          //   ),
                          // ),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) => EnterPinWidget(
                            invoiceId: widget.invoiceId,
                            cardId: '',
                            status: false,
                            reason: reason,
                          ),
                        );
                      },
                      // onPressed: vm.isLoading
                      //     ? null
                      //     : () {
                      // ref
                      //     .read(updateInvoiceStatus.notifier)
                      //     .updateInvoiceStatus(
                      //         widget.invoiceId, 'REJECT', reason, '');
                      //       },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ReasonItem {
  final String reason;
  bool isSelected;

  ReasonItem({required this.reason, this.isSelected = false});
}
